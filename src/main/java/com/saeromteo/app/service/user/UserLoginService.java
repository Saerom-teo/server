package com.saeromteo.app.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.user.UserDAO;

@Service("userLoginService")
public class UserLoginService implements UserDetailsService {
	@Autowired
	UserDAO userDAO;
	
	//UserDetailsService 구현 method
	//인코딩 디코딩 구현
	@Override
	public  UserDetails loadUserByUsername(String userEmail) throws UsernameNotFoundException {
		return userDAO.loadUserByUsername(userEmail);
	}
}
