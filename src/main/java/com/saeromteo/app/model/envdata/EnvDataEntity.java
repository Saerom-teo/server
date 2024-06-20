package com.saeromteo.app.model.envdata;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EnvDataEntity {
	private Integer envId;
	private String envTitle;
	private String envContent;
	private String envData;
	private String envMainCategory;
	private String envSubCategory;
	private String envType;
	private String enrolledDate;
}
