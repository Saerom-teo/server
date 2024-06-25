package com.saeromteo.app.dto.user;

public interface OAuth2UserInfo {

    String getProviderId();
    String getProvider();
    String getEmail();
    String getName();

}