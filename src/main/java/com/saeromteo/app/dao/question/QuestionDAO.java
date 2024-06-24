package com.saeromteo.app.dao.question;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.dto.question.QuestionDTO.QuestionRequest;
import com.saeromteo.app.dto.question.QuestionDTO.QuestionResponse;

@Repository
public class QuestionDAO{
	
	private final SqlSessionTemplate sqlSession;
    private String namespace = "com.saeromteo.question.";

    @Autowired
    public QuestionDAO(@Qualifier("questionSqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }
	
	//문의사항 전체조회
	public List<QuestionResponse> readAll(int limit, int offset) {
		Map<String, Integer> params = new HashMap<>();
		params.put("limit", limit);
		params.put("offset", offset);
		return sqlSession.selectList(namespace + "readAll", params);
	}
	
	//문의사항 수 계산
	public int getTotalQuestionCount() {
        return sqlSession.selectOne(namespace + "getTotalQuestionCount");
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
