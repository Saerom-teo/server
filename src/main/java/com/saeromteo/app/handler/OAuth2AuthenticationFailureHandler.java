package com.saeromteo.app.handler;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.OAuth2Error;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class OAuth2AuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {
        System.out.println("OAuth2 Authentication Failure: " + exception.getMessage());

        if (exception instanceof OAuth2AuthenticationException) {
            OAuth2AuthenticationException oauth2Exception = (OAuth2AuthenticationException) exception;
            OAuth2Error error = oauth2Exception.getError();
            
            System.out.println("OAuth2 Error Code: " + error.getErrorCode());
            System.out.println("OAuth2 Error Description: " + error.getDescription());
            System.out.println("OAuth2 Error URI: " + error.getUri());
        }

        System.out.println("Request URL: " + request.getRequestURL());
        System.out.println("Request Method: " + request.getMethod());
        System.out.println("Query String: " + request.getQueryString());

        super.onAuthenticationFailure(request, response, exception);
    }
}
