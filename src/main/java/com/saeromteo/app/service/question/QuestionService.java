package com.saeromteo.app.service.question;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.question.QuestionDAO;
import com.saeromteo.app.dto.question.QuestionDTO.QuestionRequest;
import com.saeromteo.app.dto.question.QuestionDTO.QuestionResponse;

@Service
public class QuestionService {
	
	@Autowired
	QuestionDAO questionDao;
	
	//문의사항 전체조회
	public List<QuestionResponse> searchAll() {
		return questionDao.searchAll();
	}
	
	//문의사항 카테고리별 조회
	public List<QuestionResponse> searchCategory(String category) {
		return questionDao.searchCategory(category);
	}
	
	//상세보기
	public QuestionResponse searchDetail(int questionId) {
		return questionDao.searchDetail(questionId);
	}
	
	//문의사항 수정
	public int questionUpdate(QuestionRequest questionId) {
		return questionDao.questionUpdate(questionId);
	}
	
	//문의사항 삭제
	public int questionDelete(int questionId) {
		return questionDao.questionDelete(questionId);
	}
	
	//문의사항 작성
	public int questionInsert(QuestionRequest questionId) {
		return questionDao.questionInsert(questionId);
	}
	
	//문의사항 답변작성
	public int questionAnswerInsert(QuestionRequest questionId) {
		return questionDao.questionAnswerInsert(questionId);
	}

}
