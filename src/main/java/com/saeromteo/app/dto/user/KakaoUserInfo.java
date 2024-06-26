package com.saeromteo.app.dto.user;

import java.util.Map;

public class KakaoUserInfo implements OAuth2UserInfo {

    private String id;
    private Map<String, Object> attributes;

    public KakaoUserInfo(Map<String, Object> attributes, String id ) {
        this.attributes = attributes;
        this.id = id;
    }

    @Override
    public String getProviderId() {
        return id;
    }

    @Override
    public String getProvider() {
        return "kakao";
    }

    @Override
    public String getEmail() {
        Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
        return kakaoAccount != null ? (String) kakaoAccount.get("email") : null;
    }

    @Override
    public String getName() {
        Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
        Map<String, Object> profile = kakaoAccount != null ? (Map<String, Object>) kakaoAccount.get("profile") : null;
        return profile != null ? (String) profile.get("nickname") : null;
    }

    @Override
    public String getProfileImage() {
        Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
        Map<String, Object> profile = kakaoAccount != null ? (Map<String, Object>) kakaoAccount.get("profile") : null;
        return profile != null ? (String) profile.get("profile_image_url") : null;
    }
}
