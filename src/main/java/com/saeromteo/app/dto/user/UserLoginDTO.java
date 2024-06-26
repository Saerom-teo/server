package com.saeromteo.app.dto.user;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.ToString;

@ToString
public class UserLoginDTO implements UserDetails {
	private static final long serialVersionUID = 1L;
	/**
     * UserDTO 클래스는 Spring Security의 UserDetails 인터페이스를 구현하여
     * 사용자 정보를 나타냅니다. 이 클래스는 사용자 이름, 비밀번호, 권한 등의 
     * 필드뿐만 아니라 사용자와 관련된 다양한 추가 정보를 포함합니다.
     * 
     */
    
	/*
	 * UserDetails 인터페이스 구현 하기 위함
	 */
    private String userEmail; // 사용자의 이름 또는 ID
    private String userPassword; // 사용자의 비밀번호
    private Collection<? extends GrantedAuthority> authorities; // 사용자의 권한 목록

    // 생성자
    public UserLoginDTO() {
    	
    }
    public UserLoginDTO(String userEmail, String userPassword, Collection<? extends GrantedAuthority> authorities) {
        this.userEmail = userEmail;
        this.userPassword = userPassword;
        this.authorities = authorities;
    }
    public UserLoginDTO(String userEmail, String userPassword) {
    	this.userEmail = userEmail;
    	this.userPassword = userPassword;
    }

    // UserDetails 인터페이스의 메서드 구현
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    @JsonProperty("userPassword")
    public String getPassword() {
        return userPassword;
    }

    @Override
    @JsonProperty("userEmail")
    public String getUsername() {
        return userEmail;
    }

    // 계정이 만료되지 않았는지 여부를 반환합니다. 여기서는 항상 true를 반환합니다.
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    // 계정이 잠겨 있지 않은지 여부를 반환합니다. 여기서는 항상 true를 반환합니다.
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    // 자격 증명이 만료되지 않았는지 여부를 반환합니다. 여기서는 항상 true를 반환합니다.
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    // 계정이 활성화되어 있는지 여부를 반환합니다. 여기서는 항상 true를 반환합니다.
    @Override
    public boolean isEnabled() {
        return true;
    }
    
    @JsonProperty("userEmail")
    public void setUsername(String userEmail) {
        this.userEmail = userEmail;
    }

    @JsonProperty("userPassword")
    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }
    
}
