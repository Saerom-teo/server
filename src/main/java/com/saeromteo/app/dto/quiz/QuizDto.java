package com.saeromteo.app.dto.quiz;

import lombok.Getter;
import lombok.Setter;

public class QuizDto {

	@Getter
	@Setter
	static public class QuizResponse {
		private Integer quizId;
		private String quizName;
		private String quizContent;
		private boolean quizAnswer;
		private Integer point;
	}

	@Getter
	@Setter
	static public class QuizRequest {
		private Integer quizId;
		private String quizName;
		private String quizContent;
		private boolean quizAnswer;
		private Integer point;
	}

}
