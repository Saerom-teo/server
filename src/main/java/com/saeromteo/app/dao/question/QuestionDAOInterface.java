package com.saeromteo.app.dao.question;

import java.util.List;

import com.saeromteo.app.model.question.QuestionDTO.QuestionRequest;
import com.saeromteo.app.model.question.QuestionDTO.QuestionResponse;

public interface QuestionDAOInterface {
	
	//문의사항 전체조회
	public List<QuestionResponse> readAll();
	
	//문의사항 카테고리별 조회
	public List<QuestionResponse> readCategory(String category);
	
	//상세보기
	public QuestionResponse readDetail(int questionId);
	
	//유저별 조회
	public List<QuestionResponse> readUser(int userCode);
	
	//문의사항 수정
	public int updateQuestion(QuestionRequest questionId);
	
	//문의사항 삭제
	public int deleteQuestion(int questionId);
	
	//문의사항 작성
	public int insertQuestion(QuestionRequest questionId);
	
	//문의사항 답변작성
	public int insertQuestionAnswer(QuestionRequest questionId);
}
