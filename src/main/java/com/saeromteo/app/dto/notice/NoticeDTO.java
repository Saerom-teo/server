package com.saeromteo.app.dto.notice;

import com.saeromteo.app.util.DateUtil;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@ToString
public class NoticeDTO {
	
	@Getter@Setter
	static public class NoticeResponse{
		private String noticeCategory;
		private String noticeTitle;
		private String noticeContent;
		private DateUtil noticeDate;
	}
	
	@Getter@Setter
	static public class NoticeRequest{
		private int noticeId;
	}
}
