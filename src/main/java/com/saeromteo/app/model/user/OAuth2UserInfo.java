package com.saeromteo.app.model.user;


public interface OAuth2UserInfo {

    String getProviderId();
    String getProvider();
    String getEmail();
    String getName();
    String getProfileImage();

}