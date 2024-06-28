package com.saeromteo.app.dto.question;

import lombok.Data;
import lombok.NoArgsConstructor;

public class QuestionDTO {
	
	@Data@NoArgsConstructor
	static public class QuestionResponse{
		private int questionId;
		private String questionCategory;
		private String questionTitle;
		private String questionContent;
		private String questionAnswer;
		private String questionDate;
		private int questionPublic;
		private int userId;
	}
	
	@Data@NoArgsConstructor
	static public class QuestionRequest{
		private int questionId;
		private String questionCategory;
		private String questionTitle;
		private String questionContent;
		private String questionAnswer;
		private String questionDate;
		private int questionPublic;
		private int userId;
	}
}
