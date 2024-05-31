package com.saeromteo.app.dao.question;

import java.util.List;

import com.saeromteo.app.dto.question.QuestionDTO.QuestionRequest;
import com.saeromteo.app.dto.question.QuestionDTO.QuestionResponse;

public interface QuestionDAOInterface {
	
	//문의사항 전체조회
	public List<QuestionResponse> searchAll();
	
	//문의사항 카테고리별 조회
	public List<QuestionResponse> searchCategory(String category);
	
	//상세보기
	public QuestionResponse searchDetail(int questionId);
	
	//유저별 조회
	public List<QuestionResponse> searchUser(int userCode);
	
	//문의사항 수정
	public int questionUpdate(QuestionRequest questionId);
	
	//문의사항 삭제
	public int questionDelete(int questionId);
	
	//문의사항 작성
	public int questionInsert(QuestionRequest questionId);
	
	//문의사항 답변작성
	public int questionAnswerInsert(QuestionRequest questionId);
}
