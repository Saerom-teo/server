package com.saeromteo.app.model.user;

import java.util.Collection;
import java.util.Collections;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.saeromteo.app.model.admin.AdminDTO;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PrincipalDetail implements UserDetails, OAuth2User {

    private static final long serialVersionUID = 1L;
    
    private AdminDTO admin;
    private UserDTO user;
    private Map<String, Object> attributes;
    
    public PrincipalDetail(String userEmail, String userPassword) {
        this.user = new UserDTO();
        this.user.setUserEmail(userEmail);
        this.user.setUserPassword(userPassword);
    }
    
    public PrincipalDetail(AdminDTO admin){
    	this.admin =admin;
    }
    
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
    @JsonProperty("userPassword")
    public String getPassword() {
        return user.getUserPassword();
    }
    
    @Override
    @JsonProperty("userEmail")
    public String getUsername() {
        return user.getUserEmail();
    }
    
    @JsonProperty("userEmail")
    public void setUsername(String userEmail) {
        if (this.user == null) {
            this.user = new UserDTO();
        }
        this.user.setUserEmail(userEmail);
    }

    @JsonProperty("userPassword")
    public void setUserPassword(String userPassword) {
        if (this.user == null) {
            this.user = new UserDTO();
        }
        this.user.setUserPassword(userPassword);
    }
    
    @Override
    public boolean isAccountNonExpired() {
        return true; // 계정이 만료되지 않음을 나타내기 위해 true 반환
    }
    
    @Override
    public boolean isAccountNonLocked() {
        return true; // 계정이 잠기지 않음을 나타내기 위해 true 반환
    }
    
    @Override
    public boolean isCredentialsNonExpired() {
        return true; // 자격 증명이 만료되지 않음을 나타내기 위해 true 반환
    }
    
    @Override
    public boolean isEnabled() {
        return true; // 계정이 활성화됨을 나타내기 위해 true 반환
    }
}
