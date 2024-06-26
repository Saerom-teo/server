package com.saeromteo.app.dao.notice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
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
	
 // 공지사항 전체조회
 	public List<NoticeResponse> readAll(int limit, int offset) {
 		Map<String, Integer> params = new HashMap<>();
 		params.put("limit", limit);
 		params.put("offset", offset);
 		return sqlSession.selectList(namespace + "readAll", params);
 	}
 	
 	public List<NoticeResponse> findByTitleContaining(Map<String, Object> params) {
        return sqlSession.selectList(namespace + "findByTitleContaining", params);
    }

    public List<NoticeResponse> findByContentContaining(Map<String, Object> params) {
        return sqlSession.selectList(namespace + "findByContentContaining", params);
    }

    public List<NoticeResponse> findAllNotices(Map<String, Object> params) {
        return sqlSession.selectList(namespace + "findAllNotices", params);
    }
 	
 	// 공지사항 수 계산
 	public int getTotalNoticeCount() {
         return sqlSession.selectOne(namespace + "getTotalNoticeCount");
     }
 	
 	// 제목으로 필터링된 공지사항 수를 가져오는 메서드
    public int getTotalNoticeCountByTitle(String query) {
        return sqlSession.selectOne(namespace + "getTotalNoticeCountByTitle", query);
    }

    // 내용으로 필터링된 공지사항 수를 가져오는 메서드
    public int getTotalNoticeCountByContent(String query) {
        return sqlSession.selectOne(namespace + ".getTotalNoticeCountByContent", query);
    }
	
    //관리자페이지에서 조회
    public List<NoticeResponse> readAllAdmin(){
    	return sqlSession.selectList(namespace + "readAllAdmin"); 
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
