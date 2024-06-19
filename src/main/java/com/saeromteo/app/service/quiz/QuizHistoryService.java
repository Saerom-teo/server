package com.saeromteo.app.service.quiz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.quiz.QuizHistoryDao;
import com.saeromteo.app.model.quiz.QuizHistoryEntity;

@Service
public class QuizHistoryService {
	
	@Autowired
	QuizHistoryDao quizHistoryDao;
	
	// Create
    public int createQuizHistory(QuizHistoryEntity entity) {
    	int result = quizHistoryDao.createQuizHistory(entity);
    	return result;
    }
    
    // Read
    public int readAllPoint(int user_id) {
    	int result = quizHistoryDao.readAllPoint(user_id);
    	return result;
    }
    
    public List<Integer> readByUserIdSolvedAt(int user_id) {
    	List<Integer> solvedQuizList = quizHistoryDao.readByUserIdSolvedAt(user_id);
    	return solvedQuizList;
    }
	
}
