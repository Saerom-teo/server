package com.saeromteo.app.model.user;

import lombok.Data;

public class UserInfoDTO {

	@Data
	static public class UserResponse {
		private int userId;
		private String userRealName;
		private String userPhone;
		private String userAddress;
		private String userDetailAddress;
	}
}
