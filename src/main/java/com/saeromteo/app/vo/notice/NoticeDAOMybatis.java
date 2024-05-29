package com.saeromteo.app.vo.notice;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAOMybatis implements NoticeDAOInterface{
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.saeromteo.app.";
	
	//공지사항 전체조회
	public List<NoticeDTO> searchAll(){
		
		return sqlSession.selectList(namespace + "searchAll");
	}
	
	//공지사항 카테고리별 조회
	public List<NoticeDTO> searchCategory(String category){
		
		return sqlSession.selectList(namespace + "searchCategory", category);
	}
	
	//공지사항 수정
	public int noticeUpdate(NoticeDTO noticeNum) {
		
		return sqlSession.update(namespace + "noticeUpdate", noticeNum);
	}
	
	//공지사항 삭제
	public int noticeDelete(NoticeDTO noticeNum) {
		
		return sqlSession.delete(namespace + "noticeDelete", noticeNum);
	}
	
	//공지사항 작성
		public int noticeInsert(NoticeDTO noticeNum) {
			
			return sqlSession.insert(namespace + "noticeInsert", noticeNum);
		}
}
