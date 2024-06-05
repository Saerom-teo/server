package com.saeromteo.app.security;
import java.util.Date;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

@Component
public class JWTUtil {

    // 보안 강화를 위해 실제 시스템에서는 변경해야 하는 비밀 키
	@Value("jwt.secretKey")
    private String secretKey;

    /**
     * 사용자 정보를 기반으로 JWT 토큰을 생성합니다.
     *
     * @param userDetails 사용자 정보
     * @return 생성된 JWT 토큰
     */
    public String generateToken(UserDetails userDetails) {
        // 현재 시간
        Date now = new Date();

        // 만료 시간 (1일)
        long expirationTime = now.getTime() + 1000 * 60 * 60 * 24;

        // JWT 토큰 생성
        return Jwts.builder()
                // 토큰 제목 (사용자 이름)
                .setSubject(userDetails.getUsername())
                // 발행 시간
                .setIssuedAt(now)
                // 만료 시간
                .setExpiration(new Date(expirationTime))
                // 서명 알고리즘 및 비밀 키를 사용하여 서명
                .signWith(SignatureAlgorithm.HS256, secretKey)
                // 압축 방식 설정 (선택 사항)
                //.compressWith(CompressionAlgorithm.GZIP)
                // 컴팩트 형식으로 문자열 변환
                .compact();
    }

    /**
     * JWT 토큰을 검증합니다.
     *
     * @param token 검증할 토큰
     * @return 토큰이 유효한지 여부
     */
    public boolean validateToken(String token) {
        try {
            // 파서를 사용하여 토큰을 파싱하고 내용 추출
            Claims claims = Jwts.parser()
                    // 서명에 사용된 비밀 키 설정
                    .setSigningKey(secretKey)
                    // 토큰 문자열 파싱
                    .parseClaimsJws(token)
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
     * JWT 토큰에서 사용자 이름을 추출합니다.
     *
     * @param token 토큰
     * @return 사용자 이름
     */
    public String getUsernameFromToken(String token) {
        // 파서를 사용하여 토큰을 파싱하고 내용 추출
        Claims claims = Jwts.parser()
                .setSigningKey(secretKey)
                .parseClaimsJws(token)
                .getBody();

        // 제목 (사용자 이름) 반환
        return claims.getSubject();
    }
}