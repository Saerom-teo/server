package com.saeromteo.app.dto.notice;

import java.sql.Date;

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
    private Date noticeDate;
}
