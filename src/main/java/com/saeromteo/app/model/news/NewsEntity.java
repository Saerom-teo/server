package com.saeromteo.app.model.news;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NewsEntity {

	private Integer newsId;
	private boolean newsCheck;
	private String newsTitle;
	private String newsDescription;
	private String newsPubdate;
	private String newsUrl;
	private String newsCategory;

}
