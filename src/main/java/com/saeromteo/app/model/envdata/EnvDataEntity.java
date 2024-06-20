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
	private String envCategory;
	private String envType;
}
