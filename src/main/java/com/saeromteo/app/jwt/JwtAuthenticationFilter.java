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

    @Autowired
    private final JWTUtil jwtUtil;

    @Autowired
    private final UserLoginService userLoginService;
    
    @Autowired
    private ServletContext servletContext;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String token = extractTokenFromRequest(httpRequest);
        String requestURI = httpRequest.getRequestURI();
        String contextPath = servletContext.getContextPath();


        if (token != null) {
            if (jwtUtil.validateToken(token)) {
            	
            	if(requestURI.startsWith(contextPath + "/auth")) {
            		 httpResponse.sendRedirect(contextPath + "/");
                     return;
            	}
                String username = jwtUtil.getUsernameFromToken(token);
                PrincipalDetail userDetails = userLoginService.loadUserByUsername(username);

                UsernamePasswordAuthenticationToken authenticationToken =
                    new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());

                SecurityContextHolder.getContext().setAuthentication(authenticationToken);
            } else {
                // 만료된 토큰인 경우
                SecurityContextHolder.clearContext();
                clearJwtCookie(httpResponse, contextPath);
                httpResponse.sendRedirect(contextPath + "/auth/login");
                return;
            }
        }
        chain.doFilter(request, response);
    }

    private String extractTokenFromRequest(HttpServletRequest request) {
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

    private void clearJwtCookie(HttpServletResponse response, String contextPath) {
        Cookie deleteCookie = new Cookie("jwtToken", null);
        deleteCookie.setPath(contextPath);
        deleteCookie.setHttpOnly(true);
        deleteCookie.setMaxAge(0); // 쿠키를 즉시 만료시킴
        response.addCookie(deleteCookie);
    }
}
