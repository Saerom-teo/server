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
public class UserService {

	@Autowired
	UserDAO userDAO;


	public UserResponse readUserforCollection(int userId) {
		UserDTO user = userDAO.readUserByUserIdforCollection(userId);
		return createUserResponseFromUserDTO(user);
	}

	public UserResponse createUserResponseFromUserDTO(UserDTO user) {
		String userAdd = user.getUserAdd();
		String[] userAdds = new String[2];

		if (userAdd != null && !userAdd.isEmpty()) {
			userAdds = userAdd.split("/", 2);
		}

		UserResponse userResponse = new UserResponse();

		userResponse.setUserId(user.getUserId());
		userResponse.setUserRealName(user.getUserRealName());
		userResponse.setUserPhone(user.getUserPhone());
		userResponse.setUserAddress(userAdds[0] != null ? userAdds[0] : "");
		userResponse.setUserDetailAddress(userAdds.length > 1 && userAdds[1] != null ? userAdds[1] : "");

		return userResponse;
	}
	
	public UserDTO readUserByUserId(int userId) {
		return userDAO.readUserByUserId(userId);
	}
	
	public int updateUser(UserDTO user){
		return userDAO.updateUser(user);
	}
}