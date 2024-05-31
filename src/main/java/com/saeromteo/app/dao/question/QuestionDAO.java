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
	public List<QuestionResponse> searchAll() {
		return sqlSession.selectList(namespace + "searchAll");
	}
	
	//문의사항 카테고리별 조회
	public List<QuestionResponse> searchCategory(String category) {
		return sqlSession.selectList(namespace + "searchCategory", category);
	}
	
	//상세보기
	public QuestionResponse searchDetail(int questionId) {
		return sqlSession.selectOne(namespace + "searchDetail", questionId);
	}
	
	//문의사항 수정
	public int questionUpdate(QuestionRequest questionId) {
		return sqlSession.update(namespace + "questionUpdate", questionId);
	}
	
	//문의사항 삭제
	public int questionDelete(int questionId) {
		return sqlSession.delete(namespace + "questionDelete", questionId);
	}
	
	//문의사항 작성
	public int questionInsert(QuestionRequest questionId) {
		return sqlSession.insert(namespace + "questionInsert", questionId);
		}
	//문의사항 답변작성
	public int questionAnswerInsert(QuestionRequest questionId) {
		return sqlSession.insert(namespace + "questionAnswerInsert", questionId);
	}
}
