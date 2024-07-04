package com.saeromteo.app.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.user.UserDAO;
import com.saeromteo.app.model.admin.AdminDTO;
import com.saeromteo.app.model.user.PrincipalDetail;
import com.saeromteo.app.model.user.UserDTO;

@Service("userLoginService")
public class UserLoginService implements UserDetailsService {
	@Autowired
	UserDAO userDAO;

	// UserDetailsService 구현 method
	// 인코딩 디코딩 구현
	@Override
	public PrincipalDetail loadUserByUsername(String userEmail) throws UsernameNotFoundException {

		AdminDTO admin = userDAO.adminLogin(userEmail);
		if (admin == null) {

			UserDTO userEntity = userDAO.loadUserByUsername(userEmail);
			if (userEntity != null) {
				System.out.println(userEntity);
				return new PrincipalDetail(userEntity); // User 타입을 인자로 하는 생성자
			}
		} else {
			
		}

		return null;
	}

	public AdminDTO adminLogin(String adminId) {
		return userDAO.adminLogin(adminId);
	}

	public int registrationoAuthUser(UserDTO user) {
		return userDAO.registrationoAuthUser(user);
	}

	public int registrationUser(UserDTO user) {
		return userDAO.registrationUser(user);
	}

	public int resetPassword(UserDTO user) {
		return userDAO.resetPassword(user);
	}
}