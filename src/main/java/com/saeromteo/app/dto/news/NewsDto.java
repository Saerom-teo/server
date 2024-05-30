package com.saeromteo.app.dto.news;

import lombok.Getter;
import lombok.Setter;

public class NewsDto {
	
	@Getter
	@Setter
	static public class NewsResponse {
		private Integer newsId;
		private boolean newsCheck;
		
	}

	@Getter
	@Setter
	static public class NewsRequest {
		private Integer newsId;
		private boolean newsCheck;
	}

}
