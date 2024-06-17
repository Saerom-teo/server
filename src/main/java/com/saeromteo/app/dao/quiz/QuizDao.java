package com.saeromteo.app.dao.quiz;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.dto.quiz.QuizDto.QuizRequest;
import com.saeromteo.app.dto.quiz.QuizDto.QuizResponse;;


@Repository
public class QuizDao {
	
	private final SqlSessionTemplate sqlSession;
    private String namespace = "com.saeromteo.quiz.";

    @Autowired
    public QuizDao(@Qualifier("quizSqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }
    
//	@Autowired
//	SqlSession sqlSession;
//	
//	String namespace = "com.saeromteo.quiz.";
	
	// Create
	public int createQuiz(QuizRequest quizDto) {
		int result = sqlSession.insert(namespace + "createQuiz", quizDto);
		return result;
	}

	// Read
	public List<QuizResponse> readAll() {
		List<QuizResponse> quizList = sqlSession.selectList(namespace + "readAll");
		return quizList;
	}

	public QuizResponse readById(int quizId) {
		QuizResponse quiz = sqlSession.selectOne(namespace + "readById", quizId);
		return quiz;
	}

	public List<QuizResponse> readByName(String quizName) {
		List<QuizResponse> quizList = sqlSession.selectList(namespace + "readByName", quizName);
		return quizList;
	}

	// Update
	public int updateQuiz(QuizRequest quizDto) {
		int result = sqlSession.update(namespace + "updateQuiz", quizDto);
		return result;
	}

	// Delete
	public int deleteQuiz(int quizId) {
		int result = sqlSession.delete(namespace + "deleteQuiz", quizId);
		return result;
	}
	
}
