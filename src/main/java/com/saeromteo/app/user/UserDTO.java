package com.saeromteo.app.user;

import java.sql.Date;
import lombok.Data;
   
@Data
public class UserDTO {
	
	/*
	 * 이름 : 유저 DTO
	 * @param .._agree 선택 사항 동의여부 M->마켓팅 수신 T->제3자 제공
	 * @param userGender MAN OR WOMAN 두자기 조건만 가능.
	 * @
	 */
	private int userCode;
    private String userEmail; 
    private String userPwd;
    private String userPhone;
    private String userNickname;
    private String userAdd;
    private Date userBirth;
    private String userGender;
    private int userMAgree;
    private int userTAgree;
    private int userCollStatus;
    private Date userJoinDate;
    private int userStatus;
    private int userPointHistory;
    private String userRank;

}
