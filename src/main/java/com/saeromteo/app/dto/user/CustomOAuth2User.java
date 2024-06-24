package com.saeromteo.app.dto.user;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.core.user.OAuth2User;

import java.util.Collection;
import java.util.Map;

public class CustomOAuth2User implements OAuth2User {

    private OAuth2User oAuth2User; // 원본 OAuth2User 객체
    private Map<String, Object> attributes; // 사용자 속성
    private String provider; // OAuth2 제공자 이름

    /**
     * 생성자: 원본 OAuth2User 객체와 사용자 속성, 제공자 이름을 받아 초기화합니다.
     *
     * @param oAuth2User 원본 OAuth2User 객체
     * @param attributes 사용자 속성
     * @param provider OAuth2 제공자 이름
     */
    public CustomOAuth2User(OAuth2User oAuth2User, Map<String, Object> attributes, String provider) {
        this.oAuth2User = oAuth2User;
        this.attributes = attributes;
        this.provider = provider;
    }

    @Override
    public Map<String, Object> getAttributes() {
        // OAuth2 제공자로부터 받은 사용자 속성(프로필 정보)들을 반환합니다.
        return attributes;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        // 사용자에게 부여된 권한 목록을 반환합니다.
        return oAuth2User.getAuthorities();
    }

    @Override
    public String getName() {
        // 사용자 이름을 반환합니다.
        // OAuth2 제공자에서 "name" 속성을 가져와 반환합니다.
        return oAuth2User.getAttribute("name");
    }

    /**
     * 이메일 주소를 반환합니다.
     * 제공자에 따라 이메일 주소를 추출하는 방식이 다릅니다.
     *
     * @return 사용자 이메일 주소
     */
    public String getEmail() {
        if (provider.equals("google")) {
            // Google 제공자로부터 받은 사용자 이메일 주소를 반환합니다.
            return (String) attributes.get("email");
        } else if (provider.equals("kakao")) {
            // Kakao 제공자로부터 받은 사용자 이메일 주소를 반환합니다.
            Map<String, Object> kakaoAccount = getSafeMap(attributes.get("kakao_account"));
            return (String) kakaoAccount.get("email");
        }
        return null;
    }

    /**
     * OAuth2 제공자의 이름을 반환합니다.
     *
     * @return 제공자 이름
     */
    public String getProvider() {
        return provider;
    }

    /**
     * 프로필 이미지를 반환합니다.
     * 제공자에 따라 프로필 이미지를 추출하는 방식이 다릅니다.
     *
     * @return 사용자 프로필 이미지 URL
     */
    public String getProfileImage() {
        if (provider.equals("google")) {
            return (String) attributes.get("picture");
        } else if (provider.equals("kakao")) {
            Map<String, Object> properties = getSafeMap(attributes.get("properties"));
            return (String) properties.get("profile_image");
        }
        return null;
    }

    /**
     * 닉네임을 반환합니다.
     * 제공자에 따라 닉네임을 추출하는 방식이 다릅니다.
     *
     * @return 사용자 닉네임
     */
    public String getNickname() {
        if (provider.equals("google")) {
            return (String) attributes.get("name");
        } else if (provider.equals("kakao")) {
            Map<String, Object> properties = getSafeMap(attributes.get("properties"));
            return (String) properties.get("nickname");
        }
        return null;
    }

    /**
     * 안전하게 Map<String, Object>로 캐스팅하는 헬퍼 메서드.
     *
     * @param object 캐스팅할 객체
     * @return 캐스팅된 Map<String, Object> 객체
     */
    @SuppressWarnings("unchecked")
    private Map<String, Object> getSafeMap(Object object) {
        return (Map<String, Object>) object;
    }
}
