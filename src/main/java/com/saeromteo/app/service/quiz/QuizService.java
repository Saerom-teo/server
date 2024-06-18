package com.saeromteo.app.service.quiz;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.quiz.QuizDao;
import com.saeromteo.app.dto.quiz.QuizDto.QuizRequest;
import com.saeromteo.app.dto.quiz.QuizDto.QuizResponse;

@Service
public class QuizService {

	@Autowired
	QuizDao quizDao;

	// Create
	public int createQuiz(QuizRequest quizDto) {
		int result = quizDao.createQuiz(quizDto);
		return result;
	}

	// Read
	public List<QuizResponse> readAll() {
		List<QuizResponse> quizList = quizDao.readAll();
		return quizList;
	}
	
	public List<QuizResponse> readRandom() {
		Random random = new Random();
		
		List<QuizResponse> quizList = quizDao.readAll();
		List<QuizResponse> quizResult = new ArrayList<>();
		
		for(int i = 0; i < 7; i++) {
			int index = random.nextInt(quizList.size());
			quizResult.add(quizList.get(index));
		}
		
		return quizResult;
	}

	public QuizResponse readById(Integer quizId) {
		QuizResponse quiz = quizDao.readById(quizId);
		return quiz;
	}

	public List<QuizResponse> readByName(String quizName) {
		List<QuizResponse> quizList = quizDao.readByName(quizName);
		return quizList;
	}

	// Update
	public int updateQuiz(QuizRequest quizDto) {
		int result = quizDao.updateQuiz(quizDto);
		return result;
	}

	// Delete
	public int deleteQuiz(int quizId) {
		int result = quizDao.deleteQuiz(quizId);
		return result;
	}
	
}
