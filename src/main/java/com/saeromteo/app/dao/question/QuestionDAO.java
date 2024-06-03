package com.saeromteo.app.dao.question;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.dto.question.QuestionDTO.QuestionRequest;
import com.saeromteo.app.dto.question.QuestionDTO.QuestionResponse;

@Repository
public class QuestionDAO implements QuestionDAOInterface{
	
	private final SqlSessionTemplate sqlSession;
    private String namespace = "com.searomteo.question.";

    @Autowired
    public QuestionDAO(@Qualifier("sqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }
    
//	@Autowired
//	SqlSession sqlSession;
//	
//	String namespace = "com.saeromteo.app.question";
	
	//臾몄쓽�궗�빆 �쟾泥댁“�쉶
	public List<QuestionResponse> searchAll() {
		return sqlSession.selectList(namespace + "searchAll");
	}
	
	//臾몄쓽�궗�빆 移댄뀒怨좊━蹂� 議고쉶
	public List<QuestionResponse> searchCategory(String category) {
		return sqlSession.selectList(namespace + "searchCategory", category);
	}
	
	//�긽�꽭蹂닿린
	public QuestionResponse searchDetail(int questionId) {
		return sqlSession.selectOne(namespace + "searchDetail", questionId);
	}
	
	//臾몄쓽�궗�빆 �닔�젙
	public int questionUpdate(QuestionRequest questionId) {
		return sqlSession.update(namespace + "questionUpdate", questionId);
	}
	
	//臾몄쓽�궗�빆 �궘�젣
	public int questionDelete(int questionId) {
		return sqlSession.delete(namespace + "questionDelete", questionId);
	}
	
	//臾몄쓽�궗�빆 �옉�꽦
	public int questionInsert(QuestionRequest questionId) {
		return sqlSession.insert(namespace + "questionInsert", questionId);
		}
	//臾몄쓽�궗�빆 �떟蹂��옉�꽦
	public int questionAnswerInsert(QuestionRequest questionId) {
		return sqlSession.insert(namespace + "questionAnswerInsert", questionId);
	}
}
