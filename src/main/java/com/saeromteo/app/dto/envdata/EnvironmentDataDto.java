package com.saeromteo.app.dto.envdata;

import lombok.Getter;
import lombok.Setter;

public class EnvironmentDataDto {

	@Getter
	@Setter
	static public class EnvDataResponse {
		private Integer env_id;
		private String env_title;
		private String env_content;
		private String env_data;
		private String env_category;
		private String env_type;
	}

	@Getter
	@Setter
	static public class EnvDataRequest {
		private Integer env_id;
		private String env_title;
		private String env_content;
		private String env_data;
		private String env_category;
		private String env_type;
	}
}
