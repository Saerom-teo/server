package com.saeromteo.app.service.question;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.question.QuestionDAO;
import com.saeromteo.app.model.notice.NoticeDTO.NoticeResponse;
import com.saeromteo.app.model.question.QuestionDTO.QuestionRequest;
import com.saeromteo.app.model.question.QuestionDTO.QuestionResponse;

@Service
public class QuestionService {
	
	@Autowired
	QuestionDAO questionDao;
	
	//문의사항 전체조회
	public List<QuestionResponse> readAll(int page, int pageSize) {
		int offset = (page - 1) * pageSize;
		return questionDao.readAll(pageSize, offset);
	}
	
	public List<QuestionResponse> findNoticesByTitle(String query, int page, int pageSize) {
		int offset = (page - 1) * pageSize;
        Map<String, Object> params = new HashMap<>();
        params.put("query", query);
        params.put("limit", pageSize);
        params.put("offset", offset);
        return questionDao.findByTitleContaining(params);
    }

    public List<QuestionResponse> findNoticesByContent(String query, int page, int pageSize) {
    	int offset = (page - 1) * pageSize;
        Map<String, Object> params = new HashMap<>();
        params.put("query", query);
        params.put("limit", pageSize);
        params.put("offset", offset);
        return questionDao.findByContentContaining(params);
    }

    public List<QuestionResponse> findAllNotices(int page, int pageSize) {
    	int offset = (page - 1) * pageSize;
        Map<String, Object> params = new HashMap<>();
        params.put("limit", pageSize);
        params.put("offset", offset);
        return questionDao.findAllQuestion(params);
    }
	
	//문의사항 수 계산
	public int getTotalQuestionCount() {
		return questionDao.getTotalQuestionCount();
	}
	
	// 제목으로 필터링된 문의사항 수를 가져오는 메서드
    public int getTotalQuestionCountByTitle(String query) {
        return questionDao.getTotalQuestionCountByTitle(query);
    }

    // 내용으로 필터링된 문의사항 수를 가져오는 메서드
    public int getTotalQuestionCountByContent(String query) {
        return questionDao.getTotalQuestionCountByContent(query);
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
	public List<QuestionResponse> readUser(int userId) {
		return questionDao.readUser(userId);
	}
	
	//관리자페이지에서 조회
    public List<QuestionResponse> readAllAdmin(){
    	return questionDao.readAllAdmin();
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
		System.out.println(questionId);
		return questionDao.insertQuestionAnswer(questionId);
	}

}
