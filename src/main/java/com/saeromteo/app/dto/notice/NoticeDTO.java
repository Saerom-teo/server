package com.saeromteo.app.dto.notice;

import java.sql.Date;

import lombok.Data;



public class NoticeDTO {
	
	@Data
	static public class NoticeResponse{
		private int noticeId;
		private String noticeCategory;
		private String noticeTitle;
		private String noticeContent;
		private Date noticeDate;
	}
	
	@Data
	static public class NoticeRequest{
		private int noticeId;
		private String noticeCategory;
		private String noticeTitle;
		private String noticeContent;
		private Date noticeDate;
	}
}
