package com.saeromteo.app.dao.notice;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.dto.notice.NoticeDTO.NoticeRequest;
import com.saeromteo.app.dto.notice.NoticeDTO.NoticeResponse;

@Repository
public class NoticeDAO implements NoticeDAOInterface{
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saeromteo.app.notice.";
	
	//공지사항 전체조회
	public List<NoticeResponse> searchAll(){
		
		return sqlSession.selectList(namespace + "searchAll");
	}
	
	//공지사항 카테고리별 조회
	public List<NoticeResponse> searchCategory(String category){
		
		return sqlSession.selectList(namespace + "searchCategory", category);
	}
	
	//상세보기
	public NoticeResponse searchDetail(int noticeId) {
		
		return sqlSession.selectOne(namespace + "searchDetail", noticeId);
	}
	
	//공지사항 수정
	public int noticeUpdate(NoticeRequest noticeId) {
		
		return sqlSession.update(namespace + "noticeUpdate", noticeId);
	}
	
	//공지사항 삭제
	public int noticeDelete(int noticeId) {
		
		return sqlSession.delete(namespace + "noticeDelete", noticeId);
	}
	
	//공지사항 작성
	public int noticeInsert(NoticeRequest noticeId) {
		
		return sqlSession.insert(namespace + "noticeInsert", noticeId);
	}
}
