package com.saeromteo.app.dao.question;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.dto.question.QuestionDTO.QuestionRequest;
import com.saeromteo.app.dto.question.QuestionDTO.QuestionResponse;

@Repository
public class QuestionDAO implements QuestionDAOInterface{
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saeromteo.app.question";
	
	//문의사항 전체조회
	public List<QuestionResponse> readAll() {
		return sqlSession.selectList(namespace + "readAll");
	}
	
	//문의사항 카테고리별 조회
	public List<QuestionResponse> readCategory(String category) {
		return sqlSession.selectList(namespace + "readCategory", category);
	}
	
	//상세보기
	public QuestionResponse readDetail(int questionId) {
		return sqlSession.selectOne(namespace + "readDetail", questionId);
	}
	
	//유저별 조회
	public List<QuestionResponse> readUser(int userCode) {
		return sqlSession.selectList(namespace + "readUser", userCode);
	}
	
	//문의사항 수정
	public int updateQuestion(QuestionRequest questionId) {
		return sqlSession.update(namespace + "updateQuestion", questionId);
	}
	
	//문의사항 삭제
	public int deleteQuestion(int questionId) {
		return sqlSession.delete(namespace + "deleteQuestion", questionId);
	}
	
	//문의사항 작성
	public int insertQuestion(QuestionRequest questionId) {
		return sqlSession.insert(namespace + "insertQuestion", questionId);
		}
	//문의사항 답변작성
	public int insertQuestionAnswer(QuestionRequest questionId) {
		return sqlSession.insert(namespace + "insertQuestionAnswer", questionId);
	}
}
