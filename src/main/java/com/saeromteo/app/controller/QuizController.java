package com.saeromteo.app.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.saeromteo.app.dto.quiz.QuizDto.QuizRequest;
import com.saeromteo.app.dto.quiz.QuizDto.QuizResponse;
import com.saeromteo.app.service.QuizService;

@RestController
@RequestMapping("/quiz/api")
public class QuizController {

	@Autowired
	QuizService quizService;

	// Create
	@PostMapping(value="/create", consumes="application/json", produces="text/plain;charset=UTF-8")
	public int createQuiz(QuizRequest quizDto) {
		int result = quizService.createQuiz(quizDto);
		return result;
	}

	// Read
	@GetMapping(value="/readAll", produces = "application/json")
	public List<QuizResponse> readAll() {
		List<QuizResponse> quizList = quizService.readAll();
		return quizList;
	}

	@GetMapping(value="/readDetail/{quizId}", produces = "application/json")
	public QuizResponse readById(int quizId) {
		QuizResponse quiz = quizService.readById(quizId);
		return quiz;
	}

	@GetMapping(value="/readByName/{quizName}", produces = "application/json")
	public List<QuizResponse> readByName(String quizName) {
		List<QuizResponse> quizList = quizService.readByName(quizName);
		return quizList;
	}

	// Update
	@PutMapping(value="/update", consumes = "application/json", produces="text/plain;charset=UTF-8")
	public int updateQuiz(QuizRequest quizDto) {
		int result = quizService.updateQuiz(quizDto);
		return result;
	}

	// Delete
	@DeleteMapping(value="/delete/{quizId}", produces="text/plain;charset=UTF-8")
	public int deleteQuiz(int quizId) {
		int result = quizService.deleteQuiz(quizId);
		return result;
	}

}
