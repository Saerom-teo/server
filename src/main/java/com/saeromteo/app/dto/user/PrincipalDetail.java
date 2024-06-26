package com.saeromteo.app.dto.user;

import java.util.Collection;
import java.util.Collections;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import lombok.Data;

@Data
public class PrincipalDetail implements UserDetails, OAuth2User {

    private static final long serialVersionUID = 1L;
    
    private UserDTO user;
    private Map<String, Object> attributes;
    
    public PrincipalDetail(UserDTO user) {
        this.user = user;
    }
    
    public PrincipalDetail(UserDTO user, Map<String, Object> attributes) {
        this.user = user;
        this.attributes = attributes;
    }    
    
    @Override
    public Map<String, Object> getAttributes() {
        return attributes;
    }
    
    @Override
    public String getName() {
        return user.getUserNickname();
    }
    
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singleton(new SimpleGrantedAuthority("ROLE_USER"));
    }
    
    @Override
    public String getPassword() {
        return user.getUserPassword();
    }
    
    @Override
    public String getUsername() {
        return user.getUserEmail();
    }
    
    @Override
    public boolean isAccountNonExpired() {
        return true; // Should return true to indicate account is not expired
    }
    
    @Override
    public boolean isAccountNonLocked() {
        return true; // Should return true to indicate account is not locked
    }
    
    @Override
    public boolean isCredentialsNonExpired() {
        return true; // Should return true to indicate credentials are not expired
    }
    
    @Override
    public boolean isEnabled() {
        return true; // Should return true to indicate account is enabled
    }
}
