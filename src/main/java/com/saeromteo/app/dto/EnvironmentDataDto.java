package com.saeromteo.app.dto;

import lombok.Getter;
import lombok.Setter;

public class EnvironmentDataDto {

	@Getter
	@Setter
	static class Response {
		private int env_id;
		private String env_title;
		private String env_content;
		private String env_data;
		private String env_category;
		private String env_type;
	}

	@Getter
	@Setter
	static class Request {
		private int env_id;
		private String env_title;
		private String env_content;
		private String env_data;
		private String env_category;
		private String env_type;
	}
}