package com.saeromteo.app.dto.envdata;

import lombok.Getter;
import lombok.Setter;

public class EnvironmentDataDto {

	@Getter
	@Setter
	static public class EnvDataResponse {
		private Integer envId;
		private String envTitle;
		private String envContent;
		private String envData;
		private String envCategory;
		private String envType;
	}

	@Getter
	@Setter
	static public class EnvDataRequest {
		private Integer envId;
		private String envTitle;
		private String envContent;
		private String envData;
		private String envCategory;
		private String envType;
	}
}
