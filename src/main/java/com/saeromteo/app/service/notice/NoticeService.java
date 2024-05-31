package com.saeromteo.app.service.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.notice.NoticeDAO;
import com.saeromteo.app.dto.notice.NoticeDTO.NoticeRequest;
import com.saeromteo.app.dto.notice.NoticeDTO.NoticeResponse;

@Service
public class NoticeService {

	@Autowired
	NoticeDAO noticeDao;
	
	//공지사항 전체조회
	public List<NoticeResponse> searchAll(){
		
		return noticeDao.searchAll();
	}
	
	//공지사항 카테고리별 조회
	public List<NoticeResponse> searchCategory(String category){	
		
		return noticeDao.searchCategory(category);
	}
	
	//상세보기
	public NoticeResponse searchDetail(int noticeNum) {
		
		return noticeDao.searchDetail(noticeNum);
	}
	
	//공지사항 수정
	public int noticeUpdate(NoticeRequest noticeNum) {
		
		return noticeDao.noticeUpdate(noticeNum);
	}
	
	//공지사항 삭제
	public int noticeDelete(int noticeNum) {
		
		return noticeDao.noticeDelete(noticeNum);
	}
	
	//공지사항 작성
	public int noticeInsert(NoticeRequest noticeNum) {
		
		return noticeDao.noticeInsert(noticeNum);
	}
}
