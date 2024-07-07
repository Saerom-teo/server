package com.saeromteo.app.service.user;

import java.sql.Date;
import java.util.NoSuchElementException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.user.UserDAO;
import com.saeromteo.app.model.user.UserDTO;
import com.saeromteo.app.model.user.UserInfoDTO.UserResponse;

@Service
public class UserService implements UserDetailsService{

	@Autowired
	UserDAO userDAO;
	 public boolean updateUserAddress(int userId ,String mainAddress, String detailAddress, int userPostalCode) {
	       try {
	            UserDTO user = readUserByUserId(userId);
	            String fullAddress = mainAddress + "/" + detailAddress;
	            user.setUserAdd(fullAddress);
	            user.setUserPostalCode(userPostalCode);
	            userDAO.updateUser(user);
	            return true;
	        } catch (Exception e) {
	            e.printStackTrace();
	            return false;
	        }
	    }

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
	  public void updateUserProfile(int userId, UserDTO updatedUser) {
	        UserDTO user = userDAO.readUserByUserId(userId);
	        
	        if (updatedUser.getUserEmail() != null) {
	            user.setUserEmail(updatedUser.getUserEmail());
	        }
	        if (updatedUser.getUserNickname() != null) {
	            user.setUserNickname(updatedUser.getUserNickname());
	        }
	        if (updatedUser.getUserBirth() != null) {
	            user.setUserBirth(updatedUser.getUserBirth());
	        }
	        if (updatedUser.getUserGender() != null) {
	            user.setUserGender(updatedUser.getUserGender());
	        }
	        if (updatedUser.getUserPhone() != null) {
	            user.setUserPhone(updatedUser.getUserPhone());
	        }
	        if (updatedUser.getUserImgPath() != null) {
	            user.setUserImgPath(updatedUser.getUserImgPath());
	        }
	        // 필요에 따라 다른 필드도 업데이트 가능
	        
	        userDAO.updateUser(user);
	    }

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		return null;
	}
	  
}