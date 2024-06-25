package com.saeromteo.app.dto.user;

import java.util.Collection;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import lombok.Data;

@Data
public class PrincipalDetail implements UserDetails ,OAuth2User {

	private static final long serialVersionUID = 1L;
	
	private UserDTO user;
    private Map<String, Object> attributes;
    
    public PrincipalDetail (UserDTO user){
    	this.user = user ;
    }
    
    public PrincipalDetail (UserDTO user , Map<String,Object> attributes){
    	this.user = user ;
    	this.attributes = attributes;
    }    
    
	@Override
	public Map<String, Object> getAttributes() {
		// TODO Auto-generated method stub
		return attributes;
	}
	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return user.getUserNickname();
	}
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return user.getUserPassword();
	}
	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return user.getUserEmail();
	}
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return false;
	}
	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return false;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return false;
	}
	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return false;
	}

}
