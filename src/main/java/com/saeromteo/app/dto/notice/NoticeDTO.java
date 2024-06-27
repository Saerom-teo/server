package com.saeromteo.app.dto.notice;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;



public class NoticeDTO {
	
	@Data@NoArgsConstructor
	static public class NoticeResponse{
		private int noticeId;
		private String noticeCategory;
		private String noticeTitle;
		private String noticeContent;
		private Date noticeDate;
	}
	
	@Data@NoArgsConstructor
	static public class NoticeRequest{
		private int noticeId;
		private String noticeCategory;
		private String noticeTitle;
		private String noticeContent;
		private String noticeDate;
	}
}
