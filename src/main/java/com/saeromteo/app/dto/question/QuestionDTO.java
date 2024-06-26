package com.saeromteo.app.dto.question;

import java.sql.Date;

import lombok.Data;

public class QuestionDTO {
	
	@Data
	static public class QuestionResponse{
		private Integer questionId;
		private String questionCategory;
		private String questionTitle;
		private String questionContent;
		private String questionAnswer;
		private Date questionDate;
		private int questionPublic;
		private int userCode;
	}
	
	@Data
	static public class QuestionRequest{
		private Integer questionId;
		private String questionCategory;
		private String questionTitle;
		private String questionContent;
		private String questionAnswer;
		private Date questionDate;
		private int questionPublic;
		private int userCode;
	}
}
