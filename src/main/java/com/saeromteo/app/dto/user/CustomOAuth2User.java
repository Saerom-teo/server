package com.saeromteo.app.dto.user;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.core.user.OAuth2User;

import lombok.ToString;

import java.util.Collection;
import java.util.Map;

@ToString
public class CustomOAuth2User implements OAuth2User {

    private OAuth2User oAuth2User;
    private String provider;

    public CustomOAuth2User(OAuth2User oAuth2User, String provider) {
        this.oAuth2User = oAuth2User;
        this.provider = provider;
    }

    @Override
    public Map<String, Object> getAttributes() {
        return oAuth2User.getAttributes();
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return oAuth2User.getAuthorities();
    }

    @Override
    public String getName() {
        return oAuth2User.getAttribute("name");
    }

    public String getEmail() {
    	System.out.println(oAuth2User.toString());
    	return oAuth2User.getAttribute("email");
    }

    public String getProvider() {
        return provider;
    }

}

