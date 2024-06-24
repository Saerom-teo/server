package com.saeromteo.app.jwt;


import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.GenericFilterBean;

import com.saeromteo.app.service.user.UserLoginService;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends GenericFilterBean {
  
	@Autowired
	private final JWTUtil jwtUtil;
	
	@Autowired
	private final UserLoginService userLoginService;

	@Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		String token = extractTokenFromRequest((HttpServletRequest) request);
        System.out.println("filter=================================");            
        
        if (token != null && jwtUtil.validateToken(token)) {
        	String username = jwtUtil.getUsernameFromToken(token);
        	UserDetails userDetails = userLoginService.loadUserByUsername(username);
           
            UsernamePasswordAuthenticationToken authenticationToken =
                    new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
            
            SecurityContextHolder.getContext().setAuthentication(authenticationToken);
        	
        }
        chain.doFilter(request, response);
    }

	    private String extractTokenFromRequest(HttpServletRequest request) {
	        // 쿠키에서 토큰 추출 시도
	        Cookie[] cookies = request.getCookies();
	        if (cookies != null) {
	            for (Cookie cookie : cookies) {
	                if ("jwtToken".equals(cookie.getName())) {  // 쿠키 이름 확인
	                    System.out.println("Token from cookie: " + cookie.getValue());
	                    return cookie.getValue();
	                }
	            }
	        }

	        // 헤더에서 토큰 추출 시도
	        String header = request.getHeader("Authorization");
	        System.out.println("Authorization header: " + header);
	        if (header != null && header.startsWith("Bearer ")) {
	            return header.substring(7);
	        }

	        return null;
	    }
	    
      
}
