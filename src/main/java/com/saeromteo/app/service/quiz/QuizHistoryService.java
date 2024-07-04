package com.saeromteo.app.service.quiz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.quiz.QuizDao;
import com.saeromteo.app.dao.quiz.QuizHistoryDao;
import com.saeromteo.app.dto.quiz.QuizHistoryRequestDto;
import com.saeromteo.app.dto.quiz.QuizDto.QuizResponse;
import com.saeromteo.app.model.point.PointEntity;
import com.saeromteo.app.model.quiz.QuizHistoryEntity;
import com.saeromteo.app.service.point.PointService;

@Service
public class QuizHistoryService {
	
	@Autowired
	QuizHistoryDao quizHistoryDao;
	@Autowired
	QuizDao quizDao;
	@Autowired
	PointService pointService;
	
	// Create
	// 정답이 맞을 경우 point 적립
    public int createQuizHistory(QuizHistoryRequestDto dto, int userId) {
    	int result = 0;
    	dto.setUser_id(userId);
    	
    	QuizResponse quizResponse = quizDao.readById(dto.getQuizId());
    	if(quizResponse.isQuizAnswer() == dto.isUserAnswer()) {
    		result = 1;
    		PointEntity point = new PointEntity();
    		point.setType("earned");
    		point.setAmount(quizDao.readById(dto.getQuizId()).getPoint());
    		point.setEarningSource("quiz");
    		point.setUserId(userId);
    		point.setComment("퀴즈 정답 보상");
    		
    		pointService.insert(point);
    	}
    	
    	quizHistoryDao.createQuizHistory(dto);
    	return result;
    }
    
    // Read
    public List<Integer> readByUserIdSolvedAt(int user_id) {
    	List<Integer> solvedQuizList = quizHistoryDao.readByUserIdSolvedAt(user_id);
    	return solvedQuizList;
    }
	
}
