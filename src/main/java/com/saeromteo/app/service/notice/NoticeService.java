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
	
	// 공지사항 전체조회
		public List<NoticeResponse> readAll(int page, int pageSize) {
			int offset = (page - 1) * pageSize;
			return noticeDao.readAll(pageSize, offset);
	}
	
	 public List<NoticeResponse> findNoticesByTitle(String title, int page, int pageSize) {
		 	int offset = (page - 1) * pageSize;
	        return noticeDao.findByTitleContaining(title, pageSize, offset);
	    }

	    public List<NoticeResponse> findNoticesByContent(String content, int page, int pageSize) {
	    	int offset = (page - 1) * pageSize;
	        return noticeDao.findByContentContaining(content, pageSize, offset);
	    }

	    public List<NoticeResponse> findAllNotices(int page, int pageSize) {
	    	int offset = (page - 1) * pageSize;
	        return noticeDao.findAll(pageSize, offset);
	    }
		
	// 공지사항 수 계산
	public int getTotalNoticeCount() {
        return noticeDao.getTotalNoticeCount();
    }
	
	//공지사항 카테고리별 조회
	public List<NoticeResponse> readCategory(String category){	
		return noticeDao.readCategory(category);
	}
	
	//상세보기
	public NoticeResponse readDetail(int noticeNum) {
		return noticeDao.readDetail(noticeNum);
	}
	
	//공지사항 수정
	public int updateNotice(NoticeRequest noticeNum) {
		return noticeDao.updateNotice(noticeNum);
	}
	
	//공지사항 삭제
	public int deleteNotice(int noticeNum) {
		return noticeDao.deleteNotice(noticeNum);
	}
	
	//공지사항 작성
	public int insertNotice(NoticeRequest noticeNum) {
		return noticeDao.insertNotice(noticeNum);
	}
}
