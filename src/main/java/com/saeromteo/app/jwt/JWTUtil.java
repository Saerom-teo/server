package com.saeromteo.app.jwt;

import java.security.Key;
import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

import com.saeromteo.app.model.admin.AdminDTO;
import com.saeromteo.app.model.user.PrincipalDetail;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;

@Component
@PropertySource("classpath:security.properties")
public class JWTUtil {

    // 보안 강화를 위해 실제 시스템에서는 변경해야 하는 비밀 키
    @Value("${jwt.secretKey}")
    private String secretKey;

    /**
     * 요청에서 JWT 토큰을 추출합니다.
     *
     * @param request 클라이언트의 HTTP 요청
     * @return 추출된 JWT 토큰 (없으면 null)
     */
    public String extractTokenFromRequest(HttpServletRequest request) {
        // 쿠키에서 토큰 추출 시도
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("jwtToken".equals(cookie.getName())) {  // 쿠키 이름 확인
                    return cookie.getValue();
                }
            }
        }
        // 헤더에서 토큰 추출 시도
        String header = request.getHeader("Authorization");
        if (header != null && header.startsWith("Bearer ")) {
            return header.substring(7);
        }
        return null;
    }

    /**
     * 클라이언트의 JWT 토큰 쿠키를 만료시킵니다.
     *
     * @param response 서버의 HTTP 응답
     * @param contextPath 애플리케이션의 컨텍스트 경로
     */
    public void clearJwtCookie(HttpServletResponse response, String contextPath) {
        Cookie deleteCookie = new Cookie("jwtToken", null);
        deleteCookie.setPath(contextPath);
        deleteCookie.setHttpOnly(true);
        deleteCookie.setMaxAge(0); // 쿠키를 즉시 만료시킴
        response.addCookie(deleteCookie);
    }

    /**
     * 요청에서 JWT 토큰을 쿠키로부터 추출합니다.
     *
     * @param request 클라이언트의 HTTP 요청
     * @return 추출된 JWT 토큰 (없으면 null)
     */
    public String getJwtFromCookies(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("jwtToken".equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
    
    public String generateAdminToken(AdminDTO admin,String role) {
        byte[] secretKeyBytes = secretKey.getBytes();
        Key secretKey = Keys.hmacShaKeyFor(secretKeyBytes);
        // 현재 시간
        Date now = new Date();
        // 만료 시간 (1일)
        long expirationTime = now.getTime() + 1000 * 60 * 60 * 24;

        // JWT 토큰 생성
        return Jwts.builder()
                // 토큰 클레임 (사용자 정보)
                .claim("userEmail", admin.getAdminId())
                .claim("role", role)
                // 발행 시간
                .setIssuedAt(now)
                // 만료 시간
                .setExpiration(new Date(expirationTime))
                // 서명 알고리즘 및 비밀 키를 사용하여 서명
                .signWith(secretKey, SignatureAlgorithm.HS256)
                // 컴팩트 형식으로 문자열 변환
                .compact();
    }
    

    /**
     * 사용자 정보를 기반으로 JWT 토큰을 생성합니다.
     *
     * @param userDetails 사용자 정보
     * @return 생성된 JWT 토큰
     */
    public String generateToken(PrincipalDetail userDetails,String role) {
        byte[] secretKeyBytes = secretKey.getBytes();
        Key secretKey = Keys.hmacShaKeyFor(secretKeyBytes);
        // 현재 시간
        Date now = new Date();

        // 만료 시간 (1일)
        long expirationTime = now.getTime() + 1000 * 60 * 60 * 24;

        // JWT 토큰 생성
        return Jwts.builder()
                // 토큰 클레임 (사용자 정보)
                .claim("id", userDetails.getUser().getUserId())
                .claim("userEmail", userDetails.getUser().getUserEmail())
                .claim("nickName", userDetails.getUser().getUserNickname())
                .claim("role", role)
                // 발행 시간
                .setIssuedAt(now)
                // 만료 시간
                .setExpiration(new Date(expirationTime))
                // 서명 알고리즘 및 비밀 키를 사용하여 서명
                .signWith(secretKey, SignatureAlgorithm.HS256)
                // 컴팩트 형식으로 문자열 변환
                .compact();
    }

    /**
     * JWT 토큰의 유효성을 검증합니다.
     *
     * @param token 검증할 토큰
     * @return 토큰이 유효한지 여부
     */
    public boolean validateToken(String token) {
        try {
            // 파서를 사용하여 토큰을 파싱하고 내용 추출
            Claims claims = Jwts.parserBuilder()
                    // 서명에 사용된 비밀 키 설정
                    .setSigningKey(Keys.hmacShaKeyFor(secretKey.getBytes()))
                    // 토큰 문자열 파싱
                    .build().parseClaimsJws(token)
                    // 내용 추출
                    .getBody();

            // 만료 시간 확인
            return claims.getExpiration().after(new Date());
        } catch (Exception e) {
            // 파싱 실패 시 유효하지 않음으로 처리
            return false;
        }
    }

    /**
     * JWT 토큰에서 사용자 이메일을 추출합니다.
     *
     * @param token 토큰
     * @return 사용자 이메일
     */
    public String getUsernameFromToken(String token) {
        // 파서를 사용하여 토큰을 파싱하고 내용 추출
        Claims claims = Jwts.parserBuilder().setSigningKey(Keys.hmacShaKeyFor(secretKey.getBytes())).build()
                .parseClaimsJws(token).getBody();

        // 사용자 이메일을 확인하고 없으면 기본 이메일로 반환
        String userEmail = claims.get("userEmail", String.class);
        if (userEmail == null || userEmail.isEmpty()) {
            userEmail = "test"; // 기본 이메일 설정
        }

        return userEmail;
    }
    /**
     * JWT 토큰에서 사용자 ID를 추출합니다.
     *
     * @param token 토큰
     * @return 사용자 ID
     */
    public int getUserIdFromToken(String token) {
        // 파서를 사용하여 토큰을 파싱하고 내용 추출
        Claims claims = Jwts.parserBuilder().setSigningKey(Keys.hmacShaKeyFor(secretKey.getBytes())).build()
                .parseClaimsJws(token).getBody();

        // 사용자 ID를 확인하고 없으면 1로 반환
        Integer userId = claims.get("id", Integer.class);
        if (userId == null) {
            userId = 1;
        }

        return userId;
    }

    /**
     * JWT 토큰에서 사용자 닉네임을 추출합니다.
     *
     * @param token 토큰
     * @return 사용자 닉네임
     */
    public String getNickNameFromToken(String token) {
        // 파서를 사용하여 토큰을 파싱하고 내용 추출
        Claims claims = Jwts.parserBuilder().setSigningKey(Keys.hmacShaKeyFor(secretKey.getBytes())).build()
                .parseClaimsJws(token).getBody();

        // 사용자 닉네임 반환
        return claims.get("nickName", String.class);
    }
    
    public String getRoleFromToken(String token) {
        // 파서를 사용하여 토큰을 파싱하고 내용 추출
        Claims claims = Jwts.parserBuilder().setSigningKey(Keys.hmacShaKeyFor(secretKey.getBytes())).build()
                .parseClaimsJws(token).getBody();

        // 사용자 닉네임 반환
        return claims.get("role", String.class);
    }
    
}
