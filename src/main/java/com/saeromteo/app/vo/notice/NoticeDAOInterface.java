package com.saeromteo.app.vo.notice;

import java.util.List;

public interface NoticeDAOInterface {
	
	//공지사항 전체조회
	public List<NoticeDTO> searchAll();
	
	//공지사항 카테고리별 조회
	public List<NoticeDTO> searchCategory(String category);
	
	//공지사항 수정
	public int noticeUpdate(NoticeDTO noticeNum);
	
	//공지사항 삭제
	public int noticeDelete(NoticeDTO noticeNum);
	
	//공지사항 작성
	public int noticeInsert(NoticeDTO noticeNum);
}
