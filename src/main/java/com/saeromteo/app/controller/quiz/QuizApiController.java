package com.saeromteo.app.controller.quiz;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.saeromteo.app.dto.quiz.QuizHistoryRequestDto;
import com.saeromteo.app.jwt.JWTUtil;
import com.saeromteo.app.dto.quiz.QuizDto.QuizRequest;
import com.saeromteo.app.dto.quiz.QuizDto.QuizResponse;
import com.saeromteo.app.model.quiz.QuizHistoryEntity;
import com.saeromteo.app.service.quiz.QuizHistoryService;
import com.saeromteo.app.service.quiz.QuizService;

@RestController
@RequestMapping("/quiz/api")
public class QuizApiController {

	@Autowired
	QuizService quizService;
	@Autowired
	QuizHistoryService quizHistoryService;
	@Autowired
	JWTUtil jwtUtil;

	// Create
	@PostMapping(value="/create", consumes="application/json", produces="text/plain;charset=UTF-8")
	public String createQuiz(@RequestBody QuizRequest quizDto) {
		int result = quizService.createQuiz(quizDto);
		return result + "건 입력";
	}
	
	@PostMapping(value="/createHistory", consumes="application/json", produces="application/json")
	public ResponseEntity<Integer> createQuizHistory(@RequestBody QuizHistoryRequestDto dto, HttpServletRequest request) {
		String token = jwtUtil.getJwtFromCookies(request);
		int userId = jwtUtil.getUserIdFromToken(token);
		
		int result = quizHistoryService.createQuizHistory(dto, userId);
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	// Read
	@GetMapping(value="/readAll", produces = "application/json")
	public List<QuizResponse> readAll() {
		List<QuizResponse> quizList = quizService.readAll();
		return quizList;
	}

	@GetMapping(value="/readDetail/{quizId}", produces = "application/json")
	public QuizResponse readById(@PathVariable("quizId") Integer quizId) {
		QuizResponse quiz = quizService.readById(quizId);
		return quiz;
	}

	@GetMapping(value="/readByName/{quizName}", produces = "application/json")
	public List<QuizResponse> readByName(@PathVariable("quizName") String quizName) {
		List<QuizResponse> quizList = quizService.readByName(quizName);
		return quizList;
	}

	// Update
	@PutMapping(value="/update", consumes = "application/json", produces="text/plain;charset=UTF-8")
	public String updateQuiz(@RequestBody QuizRequest quizDto) {
		int result = quizService.updateQuiz(quizDto);
		return result + "건 수정";
	}

	// Delete
	@DeleteMapping(value="/delete/{quizId}", produces="text/plain;charset=UTF-8")
	public String deleteQuiz(@PathVariable("quizId") Integer quizId) {
		int result = quizService.deleteQuiz(quizId);
		return result + "건 삭제";
	}

}
