package com.saeromteo.app.dao.notice;

import java.util.List;

import com.saeromteo.app.model.notice.NoticeDTO.NoticeRequest;
import com.saeromteo.app.model.notice.NoticeDTO.NoticeResponse;

public interface NoticeDAOInterface {
	
	//공지사항 전체조회
	public List<NoticeResponse> readAll();
	
	//공지사항 카테고리별 조회
	public List<NoticeResponse> readCategory(String category);
	
	//상세보기
	public NoticeResponse readDetail(int noticeId);
	
	//공지사항 수정
	public int updateNotice(NoticeRequest noticeId);
	
	//공지사항 삭제
	public int deleteNotice(int noticeId);
	
	//공지사항 작성
	public int insertNotice(NoticeRequest noticeId);
}
