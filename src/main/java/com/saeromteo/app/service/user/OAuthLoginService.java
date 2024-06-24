package com.saeromteo.app.service.user;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dto.user.CustomOAuth2User;
import com.saeromteo.app.dto.user.UserDTO;
import com.saeromteo.app.jwt.JWTUtil;


@Service("oAuthLogin")
public class OAuthLoginService extends DefaultOAuth2UserService {

    @Autowired
    private UserLoginService userLoginService;

    @Autowired
    private JWTUtil jwtUtil;

    @Autowired
    private HttpServletResponse response;
    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
    	System.out.println("==============================================");
    	System.out.println("oAuthLoginService");
    	System.out.println("==============================================");
    	int result = 0;
        OAuth2User oAuth2User = super.loadUser(userRequest);
        String registrationId = userRequest.getClientRegistration().getRegistrationId();
        Map<String, Object> attributes = oAuth2User.getAttributes();
        CustomOAuth2User customOAuth2User = new CustomOAuth2User(oAuth2User, attributes, registrationId);

        String email = customOAuth2User.getEmail();
        String name = customOAuth2User.getNickname();
        String profile = customOAuth2User.getProfileImage();

        UserDetails user = userLoginService.loadUserByUsername(email);

        if (user == null) {
            UserDTO newUser = new UserDTO();
            newUser.setUserEmail(email);
            newUser.setUserNickname(name);
            newUser.setUserImgPath(profile);

            result = userLoginService.registrationUser(newUser);
        }
        
        // 신규 유저일 경우
        if (result != 0) {
            // 새로운 사용자 등록 성공 시 실행할 로직
            // 예: 웰컴 이메일 전송, 추가 데이터 처리 등
            System.out.println("신규 사용자 등록 성공");
        } else {
            // 기존 사용자가 있을 때 실행할 로직
            System.out.println("기존 사용자 로그인");
        }
        
        String token = jwtUtil.generateToken(email);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Map<String, String> tokenMap = Map.of("token", token);
        try {
            response.sendRedirect("/auth/loginSuccess?token=" + token);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        return customOAuth2User;
    }
}
