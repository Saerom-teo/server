package com.saeromteo.app.dto.envdata;

import org.springframework.web.multipart.MultipartFile;

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
		private String envMainCategory;
		private String envSubCategory;
		private String envType;
		private String enrolledDate;
	}

	@Getter
	@Setter
	static public class EnvDataRequest {
		private Integer envId;
		private String envTitle;
		private String envContent;
		private String envData;
		private String envMainCategory;
		private String envSubCategory;
		private String envType;
	}
}
