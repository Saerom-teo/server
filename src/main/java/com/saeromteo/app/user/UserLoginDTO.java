package com.saeromteo.app.user;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Data;

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
    
//    @Getter
//    @Setter
//    static class Response {
//    	private String userEmail; // 사용자 이메일
//    	private String userPwd; // 사용자 비밀번호 (암호화된 상태)
//    	private String userPhone; // 사용자 전화번호
//    	private String userNickname; // 사용자 닉네임
//    	private String userAdd; // 사용자 주소
//    	private Date userBirth; // 사용자 생년월일
//    	private String userGender; // 사용자 성별 (MAN 또는 WOMAN)
//    	private int userMAgree; // 마케팅 수신 동의 여부 (0: 미동의, 1: 동의)
//    	private int userTAgree; // 제3자 제공 동의 여부 (0: 미동의, 1: 동의)
//    	private int userCollStatus; // 사용자 수집 상태
//    	private int userStatus; // 사용자 상태 (0: 비활성, 1: 활성)
//    }
//    
//    @Getter
//    @Setter
//    static class Request{
//    	private String userEmail; // 사용자 이메일
//    	private String userPwd; // 사용자 비밀번호 (암호화된 상태)
//    	private String userPhone; // 사용자 전화번호
//    	private int userCode; // 사용자 코드
//    	private String userNickname; // 사용자 닉네임
//    	private String userAdd; // 사용자 주소
//    	private Date userBirth; // 사용자 생년월일
//    	private String userGender; // 사용자 성별 (MAN 또는 WOMAN)
//    	private int userMAgree; // 마케팅 수신 동의 여부 (0: 미동의, 1: 동의)
//    	private int userTAgree; // 제3자 제공 동의 여부 (0: 미동의, 1: 동의)
//    	private int userCollStatus; // 사용자 수집 상태
//    	private Date userJoinDate; // 사용자 가입일
//    	private int userStatus; // 사용자 상태 (0: 비활성, 1: 활성)
//    	private int userPointHistory; // 사용자 포인트 히스토리
//    	private String userRank; // 사용자 등급
//    }

    // UserDetails 인터페이스의 메서드 구현
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return userPassword;
    }

    @Override
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
}
