package com.saeromteo.app.dto.notice;

import com.saeromteo.app.util.DateUtil;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeEntity {
	
	private int noticeId;
    private String noticeCategory;
    private String noticeTitle;
    private String noticeContent;
    private DateUtil noticeDate;
}
