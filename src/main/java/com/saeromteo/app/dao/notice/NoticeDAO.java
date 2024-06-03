package com.saeromteo.app.dao.notice;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.dto.notice.NoticeDTO.NoticeRequest;
import com.saeromteo.app.dto.notice.NoticeDTO.NoticeResponse;

@Repository
public class NoticeDAO implements NoticeDAOInterface{
	
	private final SqlSessionTemplate sqlSession;
    private String namespace = "com.searomteo.notice.";

    @Autowired
    public NoticeDAO(@Qualifier("sqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }
	
//	@Autowired
//	SqlSession sqlSession;
//	
//	String namespace = "com.saeromteo.app.notice.";
	
	//怨듭��궗�빆 �쟾泥댁“�쉶
	public List<NoticeResponse> searchAll(){
		
		return sqlSession.selectList(namespace + "searchAll");
	}
	
	//怨듭��궗�빆 移댄뀒怨좊━蹂� 議고쉶
	public List<NoticeResponse> searchCategory(String category){
		
		return sqlSession.selectList(namespace + "searchCategory", category);
	}
	
	//�긽�꽭蹂닿린
	public NoticeResponse searchDetail(int noticeId) {
		
		return sqlSession.selectOne(namespace + "searchDetail", noticeId);
	}
	
	//怨듭��궗�빆 �닔�젙
	public int noticeUpdate(NoticeRequest noticeId) {
		
		return sqlSession.update(namespace + "noticeUpdate", noticeId);
	}
	
	//怨듭��궗�빆 �궘�젣
	public int noticeDelete(int noticeId) {
		
		return sqlSession.delete(namespace + "noticeDelete", noticeId);
	}
	
	//怨듭��궗�빆 �옉�꽦
	public int noticeInsert(NoticeRequest noticeId) {
		
		return sqlSession.insert(namespace + "noticeInsert", noticeId);
	}
}
