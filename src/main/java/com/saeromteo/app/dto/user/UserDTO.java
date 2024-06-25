package com.saeromteo.app.dto.user;

import java.io.Serializable;
import java.sql.Date;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class UserDTO implements Serializable{
	private static final long serialVersionUID = 1L;
		private int userCode;
	    private String userEmail;
	    private String userPassword;
	    private String userPhone;
	    private String userNickname;
	    private String userAdd;
	    private Date userBirth;
	    private String userGender;
	    private boolean userMAgree;
	    private boolean userTAgree;
	    private boolean userCollStatus;
	    private Date userJoinDate;
	    private boolean userStatus;
	    private int userPointHistory;
	    private String userRank;
	    private String userImgPath;
	    private Integer userPostalCode;
}
