package com.saeromteo.app.jwt;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

        // 쿠키에서 JWT 토큰 추출
        String token = jwtUtil.getJwtFromCookies(httpRequest);
        String requestURI = httpRequest.getRequestURI();
        String contextPath = servletContext.getContextPath();

        if (token != null) {
            if (jwtUtil.validateToken(token)) {
                if (requestURI.startsWith(contextPath + "/auth")) {
                    httpResponse.sendRedirect(contextPath + "/");
                    return;
                }

                String username = jwtUtil.getUsernameFromToken(token);
                PrincipalDetail userDetails = userLoginService.loadUserByUsername(username);

                if (userDetails != null) {
                    UsernamePasswordAuthenticationToken authenticationToken =
                        new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
                    SecurityContextHolder.getContext().setAuthentication(authenticationToken);
                } else {
                    SecurityContextHolder.clearContext();
                    jwtUtil.clearJwtCookie(httpResponse, contextPath);
                    httpResponse.sendRedirect(contextPath + "/auth/login");
                    return;
                }
            } else {
                SecurityContextHolder.clearContext();
                jwtUtil.clearJwtCookie(httpResponse, contextPath);
                httpResponse.sendRedirect(contextPath + "/auth/login");
                return;
            }
        } else {
            SecurityContextHolder.clearContext();
        }

        chain.doFilter(request, response);
    }

}
