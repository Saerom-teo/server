package com.saeromteo.app.dao.notice;

import java.util.List;

import com.saeromteo.app.dto.notice.NoticeDTO.NoticeRequest;
import com.saeromteo.app.dto.notice.NoticeDTO.NoticeResponse;

public interface NoticeDAOInterface {
	
	//공지사항 전체조회
	public List<NoticeResponse> searchAll();
	
	//공지사항 카테고리별 조회
	public List<NoticeResponse> searchCategory(String category);
	
	//상세보기
	public NoticeResponse searchDetail(int noticeNum);
	
	//공지사항 수정
	public int noticeUpdate(NoticeRequest noticeNum);
	
	//공지사항 삭제
	public int noticeDelete(int noticeNum);
	
	//공지사항 작성
	public int noticeInsert(NoticeRequest noticeNum);
}
