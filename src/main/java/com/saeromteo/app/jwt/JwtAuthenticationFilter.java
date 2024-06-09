package com.saeromteo.app.jwt;


import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
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
	        String header = request.getHeader("Authorization");
	        if (header != null && header.startsWith("Bearer ")) {
	            return header.substring(7);
	        }
	        return null;
	    }
      
}
