package com.saeromteo.app.dto.question;

import com.saeromteo.app.util.DateUtil;

import lombok.Getter;
import lombok.Setter;

public class QuestionDTO {
	
	@Getter@Setter
	static public class QuestionResponse{
		private int questionId;
		private String questionCategory;
		private String questionTitle;
		private String questionContent;
		private String questionAnswer;
		private DateUtil questionDate;
		private int questionPublic;
	}
	
	@Getter@Setter
	static public class QuestionRequest{
		private int questionId;
		private String questionCategory;
		private String questionTitle;
		private String questionContent;
		private String questionAnswer;
		private DateUtil questionDate;
		private int questionPublic;
	}
}
