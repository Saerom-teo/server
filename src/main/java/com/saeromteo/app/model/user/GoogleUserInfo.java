package com.saeromteo.app.model.user;

import java.util.Map;

// Google 사용자 정보를 구현한 클래스
public class GoogleUserInfo implements OAuth2UserInfo {
    private Map<String, Object> attributes;

    public GoogleUserInfo(Map<String, Object> attributes) {
        this.attributes = attributes;
    }

    @Override
    public String getProviderId() {
        return String.valueOf(attributes.get("sub")); // 제공자 ID 반환
    }

    @Override
    public String getProvider() {
        return "google"; // 제공자 이름 반환
    }

    @Override
    public String getEmail() {
        return String.valueOf(attributes.get("email")); // 이메일 반환
    }

    @Override
    public String getName() {
        return String.valueOf(attributes.get("name")); // 사용자 이름 반환
    }

    @Override
    public String getProfileImage() {
        return String.valueOf(attributes.get("picture")); // 프로필 이미지 URL 반환
    }
}
