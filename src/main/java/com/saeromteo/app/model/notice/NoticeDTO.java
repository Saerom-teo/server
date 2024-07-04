package com.saeromteo.app.model.notice;

import lombok.Data;
import lombok.NoArgsConstructor;



public class NoticeDTO {
	
	@Data@NoArgsConstructor
	static public class NoticeResponse{
		private int noticeId;
		private String noticeCategory;
		private String noticeTitle;
		private String noticeContent;
		private String noticeDate;
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
