package com.saeromteo.app.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class UserLoginService implements UserDetailsService {
	@Autowired
	UserDAO userDAO;
	
	public UserLoginDTO selectById(String userId) {
		return userDAO.selectById();
	}

	//UserDetailsService 구현 method
	//인코딩 디코딩 구현
	@Override
	public  UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
		
		return userDAO.selectById();
	}
}
