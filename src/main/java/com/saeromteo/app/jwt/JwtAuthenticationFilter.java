package com.saeromteo.app.jwt;

import java.io.IOException;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.GenericFilterBean;

import com.saeromteo.app.model.user.PrincipalDetail;
import com.saeromteo.app.service.user.UserLoginService;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends GenericFilterBean {

    // JWT 유틸리티 클래스
    @Autowired
    private final JWTUtil jwtUtil;

    // 사용자 로그인 서비스
    @Autowired
    private final UserLoginService userLoginService;
    
    // 서블릿 컨텍스트
    @Autowired
    private ServletContext servletContext;

    /**
     * 필터링 로직을 처리하는 메서드
     *
     * @param request  클라이언트의 서블릿 요청
     * @param response 클라이언트의 서블릿 응답
     * @param chain    필터 체인
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // 요청에서 JWT 토큰 추출
        String token = jwtUtil.extractTokenFromRequest(httpRequest);
        // 요청 URI
        String requestURI = httpRequest.getRequestURI();
        // 컨텍스트 경로
        String contextPath = servletContext.getContextPath();

        if (token != null) {
            // 토큰이 유효한 경우
            if (jwtUtil.validateToken(token)) {
                // auth로 시작하는 경로에 대한 요청을 리다이렉트
                if (requestURI.startsWith(contextPath + "/auth")) {
                    httpResponse.sendRedirect(contextPath + "/");
                    return;
                }

                // 토큰에서 사용자 이름 추출
                String username = jwtUtil.getUsernameFromToken(token);
                // 사용자 정보를 로드
                PrincipalDetail userDetails = userLoginService.loadUserByUsername(username);

                // 인증 토큰 생성
                UsernamePasswordAuthenticationToken authenticationToken =
                    new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());

                // 보안 컨텍스트에 인증 정보 설정
                SecurityContextHolder.getContext().setAuthentication(authenticationToken);
            } else {
                // 만료된 토큰인 경우
                SecurityContextHolder.clearContext();
                // JWT 쿠키 삭제
                jwtUtil.clearJwtCookie(httpResponse, contextPath);
                // 로그인 페이지로 리다이렉트
                httpResponse.sendRedirect(contextPath + "/auth/login");
                return;
            }
        }

        // 필터 체인 계속 진행
        chain.doFilter(request, response);
    }

}
