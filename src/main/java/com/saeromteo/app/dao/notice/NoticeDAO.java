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
	
	//공지사항 전체조회
	public List<NoticeResponse> readAll(){
		return sqlSession.selectList(namespace + "readAll");
	}
	
	//공지사항 카테고리별 조회
	public List<NoticeResponse> readCategory(String category){
		return sqlSession.selectList(namespace + "readCategory", category);
	}
	
	//상세보기
	public NoticeResponse readDetail(int noticeId) {
		return sqlSession.selectOne(namespace + "readDetail", noticeId);
	}
	
	//공지사항 수정
	public int updateNotice(NoticeRequest noticeId) {
		int result = sqlSession.update(namespace + "updateNotice", noticeId);
		return result;
	}
	
	//공지사항 삭제
	public int deleteNotice(int noticeId) {
		int result = sqlSession.delete(namespace + "deleteNotice", noticeId);
		return result;
	}
	
	//공지사항 작성
	public int insertNotice(NoticeRequest noticeId) {
		int result = sqlSession.insert(namespace + "insertNotice", noticeId);
		return result;
	}
}
