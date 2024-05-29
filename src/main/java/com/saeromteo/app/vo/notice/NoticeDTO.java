package com.saeromteo.app.vo.notice;

import com.saeromteo.app.util.DateUtil;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter@Setter
@ToString
public class NoticeDTO {
	
	static class Response{
		int noticeNum;
		String noticeCategory;
		String noticeTitle;
		String noticeContent;
		DateUtil noticeDate;
	}
	
}
