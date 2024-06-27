package com.saeromteo.app.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.user.UserDAO;
import com.saeromteo.app.dto.user.PrincipalDetail;
import com.saeromteo.app.dto.user.UserDTO;

@Service("userLoginService")
public class UserLoginService implements UserDetailsService {
	@Autowired
	UserDAO userDAO;
	
	//UserDetailsService 구현 method
	//인코딩 디코딩 구현
	@Override
	public UserDetails loadUserByUsername(String userEmail) throws UsernameNotFoundException {
		System.out.println("loadLogin-=====================");
		UserDTO userEntity = userDAO.loadUserByUsername(userEmail);
	        if(userEntity != null){
	            return new PrincipalDetail(userEntity); //User 타입을 인자로 하는 생성자
	        }
	        return null;
	}
	
	public int registrationoAuthUser(UserDTO user){
		return userDAO.registrationoAuthUser(user);
	}
}
