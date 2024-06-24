package com.saeromteo.app.dto.user;

import java.sql.Date;

import lombok.Data;

@Data
public class UserDTO {
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
