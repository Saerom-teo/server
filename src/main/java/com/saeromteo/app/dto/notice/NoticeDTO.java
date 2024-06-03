package com.saeromteo.app.dto.notice;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@ToString
public class NoticeDTO {
	
	@Getter@Setter
	static public class NoticeResponse{
		private int noticeId;
		private String noticeCategory;
		private String noticeTitle;
		private String noticeContent;
		private Date noticeDate;
	}
	
	@Getter@Setter
	static public class NoticeRequest{
		private int noticeId;
		private String noticeCategory;
		private String noticeTitle;
		private String noticeContent;
		private Date noticeDate;
	}
}
