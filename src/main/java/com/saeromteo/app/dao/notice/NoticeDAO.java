package com.saeromteo.app.dao.notice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.dto.notice.NoticeDTO.NoticeRequest;
import com.saeromteo.app.dto.notice.NoticeDTO.NoticeResponse;

@Repository
public class NoticeDAO{
	
	private final SqlSessionTemplate sqlSession;
    private String namespace = "com.saeromteo.notice.";

    @Autowired
    public NoticeDAO(@Qualifier("noticeSqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }

	
	//공지사항 전체조회
	public List<NoticeResponse> readAll(int limit, int offset){
		Map<String, Integer> params = new HashMap<>();
		params.put("limit", limit);
		params.put("offset", offset);
		return sqlSession.selectList(namespace + "readAll", params);
	}
	
	//공지사항 count
	public int getTotalNoticeCount() {
        return sqlSession.selectOne("com.saeromteo.notice.getTotalNoticeCount");
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
