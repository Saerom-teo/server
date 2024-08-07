package com.saeromteo.app.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.saeromteo.app.dao.user.UserDAO;
import com.saeromteo.app.model.user.GoogleUserInfo;
import com.saeromteo.app.model.user.KakaoUserInfo;
import com.saeromteo.app.model.user.OAuth2UserInfo;
import com.saeromteo.app.model.user.PrincipalDetail;
import com.saeromteo.app.model.user.UserDTO;

@Service("oAuthService")
public class OAuthLoginService implements OAuth2UserService<OAuth2UserRequest, OAuth2User>{
    @Autowired
    UserDAO userDao;
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        OAuth2User oAuth2User = new DefaultOAuth2UserService().loadUser(userRequest);
        OAuth2UserInfo oAuth2UserInfo;
        System.out.println("oAuthService");
        String registrationId = userRequest.getClientRegistration().getRegistrationId();
        if (registrationId.equals("google")) {
            oAuth2UserInfo = new GoogleUserInfo(oAuth2User.getAttributes());
        } else if (registrationId.equals("kakao")) {
            oAuth2UserInfo = new KakaoUserInfo(oAuth2User.getAttributes(), String.valueOf(oAuth2User.getAttributes().get("id")));
        } else {
            throw new IllegalArgumentException("Unsupported provider: " + registrationId);
        }

        String username = oAuth2UserInfo.getName();
        String email = oAuth2UserInfo.getEmail();
        UserDTO userEntity = new UserDTO();
            userEntity = new UserDTO();
            userEntity.setUserEmail(email);
            userEntity.setUserNickname(username);

            return new PrincipalDetail(userEntity, oAuth2User.getAttributes());
    }
}
