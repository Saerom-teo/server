package com.saeromteo.app.dao.quiz;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.model.quiz.QuizHistoryEntity;

@Repository
public class QuizHistoryDao {
	
	private final SqlSessionTemplate sqlSession;
    private String namespace = "com.saeromteo.quiz.";

    @Autowired
    public QuizHistoryDao(@Qualifier("quizSqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }
    
    // Create
    public int createQuizHistory(QuizHistoryEntity entity) {
    	int result = sqlSession.insert(namespace + "createQuizHistory", entity);
    	return result;
    }
    
    // Read
    public int readAllPoint(int user_id) {
    	int result = sqlSession.selectOne(namespace + "readAllPoint", user_id);
    	return result;
    }
    
    public List<Integer> readByUserIdSolvedAt(int user_id) {
    	List<Integer> solvedQuizList = sqlSession.selectList(namespace + "readByUseridSolvedat", user_id);
    	return solvedQuizList;
    }
	
}
