package com.saeromteo.app.dto;

import lombok.Getter;
import lombok.Setter;

public class EnvironmentDataDto {

	@Getter
	@Setter
	static public class Response {
		private Integer env_id;
		private String env_title;
		private String env_content;
		private String env_data;
		private String env_category;
		private String env_type;
	}

	@Getter
	@Setter
	static public class Request {
		private Integer env_id;
		private String env_title;
		private String env_content;
		private String env_data;
		private String env_category;
		private String env_type;
	}
}
