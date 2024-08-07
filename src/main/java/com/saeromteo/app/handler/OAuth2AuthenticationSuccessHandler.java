package com.saeromteo.app.handler;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import com.saeromteo.app.jwt.JWTUtil;
import com.saeromteo.app.model.user.PrincipalDetail;
import com.saeromteo.app.model.user.UserDTO;
import com.saeromteo.app.service.point.PointService;
import com.saeromteo.app.service.user.UserLoginService;

@Component
public class OAuth2AuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private JWTUtil jwtUtil;

    @Autowired
    private UserLoginService userService;
    
    @Autowired
    private PointService pointService;
    
    private RequestCache requestCache = new HttpSessionRequestCache();
    
    
    public OAuth2AuthenticationSuccessHandler(JWTUtil jwtUtil, UserLoginService userService) {
        this.jwtUtil = jwtUtil;
        this.userService = userService;
    }
    
    private static final String ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    private static final SecureRandom RANDOM = new SecureRandom();

    public static String generateTemporaryPassword(int length) {
        StringBuilder password = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            password.append(ALPHABET.charAt(RANDOM.nextInt(ALPHABET.length())));
        }
        return password.toString();
    }
    

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException {
    	  SavedRequest savedRequest = requestCache.getRequest(request, response);
    	  
    	if (authentication.getPrincipal() instanceof OAuth2User) {
            System.out.println("onAuthenticationSuccess 핸들러 호출 ");
            OAuth2User oauth2User = (OAuth2User) authentication.getPrincipal();
            Map<String, Object> attributes = oauth2User.getAttributes();
            String email = null;
            String providerId = null;

            // Google 로그인 이메일 추출
            if (attributes.containsKey("sub")) {
                email = (String) attributes.get("email");
                providerId = (String) attributes.get("sub");
            } else if (attributes.containsKey("id")) {
                // Kakao 로그인 이메일 추출
                providerId = String.valueOf(attributes.get("id"));
                Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
                if (kakaoAccount != null) {
                    email = (String) kakaoAccount.get("email");
                }
            }
            
            PrincipalDetail user = userService.loadUserByUsername(email);
            // 유저가 존재하는지 확인 여기서부터 내일 로직 작성
            if (user == null) {
                // 신규 유저
            	user = new PrincipalDetail(new UserDTO());
                user.getUser().setUserEmail(email);
                user.getUser().setUserImgPath(getUserImage(attributes));
                user.getUser().setUserPassword(generateTemporaryPassword(50));
                // 이메일에서 '@' 앞부분만 추출하여 닉네임으로 설정
                String nickname = email.substring(0, email.indexOf('@'));
                user.getUser().setUserNickname(nickname);
                user.getUser().setUserStatus(true);
                int result = userService.registrationoAuthUser(user.getUser());
                PrincipalDetail oAuthUser = userService.loadUserByUsername(email) ;
    			UserDTO regiUser = oAuthUser.getUser();
    			pointService.insertPoint(regiUser.getUserId(),100,"earned", "admin", "신규 가입 웰컴 포인트");
                if (result != 1) {
                    System.out.println("회원가입시 에러 발생");
                }
            }
            PrincipalDetail oAuthUser = userService.loadUserByUsername(email) ;
            String jwtToken = jwtUtil.generateToken(oAuthUser,"user");
            
            // 유저가 존재하면 JWT 토큰 생성 및 쿠키에 저장
            Cookie jwtCookie = new Cookie("jwtToken", jwtToken);
            jwtCookie.setPath("/");
            jwtCookie.setHttpOnly(false);
            jwtCookie.setMaxAge(24 * 60 * 60);

            response.addCookie(jwtCookie);

                response.sendRedirect(getBaseUrl(request) + "/");
                return;
            
        } else {
            response.sendRedirect(getBaseUrl(request) + "/auth/login");
        }
    }

    private String getBaseUrl(HttpServletRequest request) {
        String scheme = request.getScheme();             // http
        String serverName = request.getServerName();     // hostname.com
        int serverPort = request.getServerPort();        // 800
        String contextPath = request.getContextPath();   // /mywebapp

        // Check if the port is standard for the scheme
        if ((scheme.equals("http") && serverPort == 80) || (scheme.equals("https") && serverPort == 443)) {
            serverPort = -1;
        }

        StringBuilder url = new StringBuilder();
        url.append(scheme).append("://").append(serverName);

        if (serverPort != -1) {
            url.append(":").append(serverPort);
        }

        url.append(contextPath);
        return url.toString();
    }
    
    private String getUserImage(Map<String, Object> attributes) {
        if (attributes.containsKey("picture")) {
            // For Google OAuth
            return (String) attributes.get("picture");
        } else if (attributes.containsKey("properties")) {
            // For Kakao OAuth
            Map<String, Object> properties = (Map<String, Object>) attributes.get("properties");
            if (properties.containsKey("profile_image")) {
                return (String) properties.get("profile_image");
            }
        }
        return null;
    }

    public String getUserNickname(Map<String, Object> attributes) {
        if (attributes.containsKey("name")) {
            // For Google OAuth
            return (String) attributes.get("name");
        } else if (attributes.containsKey("properties")) {
            // For Kakao OAuth
            Map<String, Object> properties = (Map<String, Object>) attributes.get("properties");
            if (properties.containsKey("nickname")) {
                return (String) properties.get("nickname");
            }
        }
        return null;
    }
}
