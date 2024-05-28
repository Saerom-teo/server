package com.saeromteo.app.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EnvironmentDataDto {
	private int env_id;
	private String env_title;
	private String env_content;
	private String env_data;
	private String env_category;
	private String env_type;
}
