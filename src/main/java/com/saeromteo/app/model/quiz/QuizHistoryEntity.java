package com.saeromteo.app.model.quiz;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QuizHistoryEntity {

	Integer user_id;
	Integer quizId;
	Date solvedAt;
	boolean userAnswer;
	
}
