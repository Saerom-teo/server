package com.saeromteo.app.dto.user;

import java.util.Map;

// Kakao 사용자 정보를 구현한 클래스
public class KakaoUserInfo implements OAuth2UserInfo {

    private String id;
    private Map<String, Object> kakaoAccount;

    public KakaoUserInfo(Map<String, Object> kakaoAccount, String id ) {
        this.kakaoAccount = kakaoAccount;
        this.id = id;
    }

    @Override
    public String getProviderId() {
        return id; // 제공자 ID 반환
    }

    @Override
    public String getProvider() {
        return "kakao"; // 제공자 이름 반환
    }

    @Override
    public String getEmail() {
        return String.valueOf(kakaoAccount.get("email")); // 이메일 반환
    }

    @Override
    public String getName() {
        Map<String, Object> profile = (Map<String, Object>) kakaoAccount.get("profile");
        return profile != null ? String.valueOf(profile.get("nickname")) : null; // 사용자 이름 반환
    }
}
