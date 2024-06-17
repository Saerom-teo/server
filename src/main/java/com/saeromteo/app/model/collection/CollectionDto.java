package com.saeromteo.app.model.collection;

import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;


public class CollectionDto {

	@Setter
	@Getter
	static public class SubmitRequest {
		private String name;
		private String phone;
		private String address;
		private String detailAddress;

		// Getters and Setters
		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getPhone() {
			return phone;
		}

		public void setPhone(String phone) {
			this.phone = phone;
		}

		public String getAddress() {
			return address;
		}

		public void setAddress(String address) {
			this.address = address;
		}

		public String getDetailAddress() {
			return detailAddress;
		}

		public void setDetailAddress(String detailAddress) {
			this.detailAddress = detailAddress;
		}
	}

	@ApiModelProperty(notes = "수거번호", example = "C0604001", required = true)
	private String collectionId;

	@ApiModelProperty(notes = "유저 id", example = "34", required = true)
	private int userId;

	@ApiModelProperty(notes = "이미지 주소", example = "https://images.com/image.jpg", required = true)
	private String image;

}
