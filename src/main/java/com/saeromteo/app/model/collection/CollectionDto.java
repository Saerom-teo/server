package com.saeromteo.app.model.collection;

import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;


public class CollectionDto {

	@Setter
	@Getter
	static public class RegistRequest {
		private String name;
		private String phone;
		private String address;
		private String detailAddress;
	}

	@ApiModelProperty(notes = "수거번호", example = "C0604001", required = true)
	private String collectionId;

	@ApiModelProperty(notes = "유저 id", example = "34", required = true)
	private int userId;

	@ApiModelProperty(notes = "이미지 주소", example = "https://images.com/image.jpg", required = true)
	private String image;

}
