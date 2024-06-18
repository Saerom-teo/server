package com.saeromteo.app.model.quiz;

import lombok.Getter;

import lombok.Setter;

@Getter
@Setter
public class QuizEntity {
	
	private Integer quizId;
	private String quizName;
	private String quizContent;
	private boolean quizAnswer;
	
}
