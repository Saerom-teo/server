package com.saeromteo.app.handler;

import java.io.IOException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.saeromteo.app.jwt.JWTUtil;

@Component
public class OAuth2AuthenticationSuccessHandler implements AuthenticationSuccessHandler {

	@Autowired
    private JWTUtil jwtUtil;

    public OAuth2AuthenticationSuccessHandler(JWTUtil jwtUtil) {
        this.jwtUtil = jwtUtil;
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException {
    	if (authentication.getPrincipal() instanceof OAuth2User) {
            OAuth2User oauth2User = (OAuth2User) authentication.getPrincipal();
            String jwtToken = jwtUtil.generateToken(oauth2User.getName());

            Cookie jwtCookie = new Cookie("jwt", jwtToken);
            jwtCookie.setPath("/");
            jwtCookie.setHttpOnly(true);
            jwtCookie.setMaxAge(7 * 24 * 60 * 60);
            response.addCookie(jwtCookie);

            response.sendRedirect("/home");
        } else {
            response.sendRedirect("/auth/login?error=true");
        }
    }
}