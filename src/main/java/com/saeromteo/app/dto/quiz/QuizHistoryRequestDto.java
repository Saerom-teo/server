package com.saeromteo.app.dto.quiz;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QuizHistoryRequestDto {
	Integer user_id;
	Integer quizId;
	boolean userAnswer;
}
