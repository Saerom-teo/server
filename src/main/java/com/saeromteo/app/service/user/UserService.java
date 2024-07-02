package com.saeromteo.app.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.user.UserDAO;
import com.saeromteo.app.model.user.PrincipalDetail;
import com.saeromteo.app.model.user.UserDTO;
import com.saeromteo.app.model.user.UserInfoDTO.UserResponse;

@Service
public class UserService implements UserDetailsService {

	@Autowired
	UserDAO userDAO;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		return null;
	}

	public UserResponse readUserforCollection(int userId) {
		UserDTO user = userDAO.readUserByUserIdforCollection(userId);
		return createUserResponseFromUserDTO(user);
	}

	public UserResponse createUserResponseFromUserDTO(UserDTO user) {
		String[] userAdds = user.getUserAdd().split("/");
		
		UserResponse userResponse = new UserResponse();
		
		userResponse.setUserId(user.getUserId());
		userResponse.setUserRealName(user.getUserRealName());
		userResponse.setUserPhone(user.getUserPhone());
		userResponse.setUserAddress(userAdds[0]);
		userResponse.setUserDetailAddress(userAdds[1]);
		
		return userResponse;
	}
}