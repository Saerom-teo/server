package com.saeromteo.app.service.question;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.question.QuestionDAO;
import com.saeromteo.app.dto.notice.NoticeDTO.NoticeResponse;
import com.saeromteo.app.dto.question.QuestionDTO.QuestionRequest;
import com.saeromteo.app.dto.question.QuestionDTO.QuestionResponse;

@Service
public class QuestionService {
	
	@Autowired
	QuestionDAO questionDao;
	
	//문의사항 전체조회
	public List<QuestionResponse> readAll(int page, int pageSize) {
		int offset = (page - 1) * pageSize;
		return questionDao.readAll(pageSize, offset);
	}
	
	public List<QuestionResponse> findNoticesByTitle(String title, int page, int pageSize) {
	 	int offset = (page - 1) * pageSize;
        return questionDao.findByTitleContaining(title, pageSize, offset);
    }

    public List<QuestionResponse> findNoticesByContent(String content, int page, int pageSize) {
    	int offset = (page - 1) * pageSize;
        return questionDao.findByContentContaining(content, pageSize, offset);
    }

    public List<QuestionResponse> findAllNotices(int page, int pageSize) {
    	int offset = (page - 1) * pageSize;
        return questionDao.findAll(pageSize, offset);
    }
	
	//문의사항 수 계산
	public int getTotalQuestionCount() {
		return questionDao.getTotalQuestionCount();
	}
	
	//문의사항 카테고리별 조회
	public List<QuestionResponse> readCategory(String category) {
		return questionDao.readCategory(category);
	}
	
	//상세보기
	public QuestionResponse readDetail(int questionId) {
		return questionDao.readDetail(questionId);
	}
	
	//유저별 조회
	public List<QuestionResponse> readUser(int userCode) {
		return questionDao.readUser(userCode);
	}
	
	//문의사항 수정
	public int updateQuestion(QuestionRequest questionId) {
		return questionDao.updateQuestion(questionId);
	}
	
	//문의사항 삭제
	public int deleteQuestion(int questionId) {
		return questionDao.deleteQuestion(questionId);
	}
	
	//문의사항 작성
	public int insertQuestion(QuestionRequest questionId) {
		return questionDao.insertQuestion(questionId);
	}
	
	//문의사항 답변작성
	public int insertQuestionAnswer(QuestionRequest questionId) {
		return questionDao.insertQuestionAnswer(questionId);
	}

}
