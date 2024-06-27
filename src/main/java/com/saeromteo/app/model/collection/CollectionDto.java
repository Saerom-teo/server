package com.saeromteo.app.model.collection;

import java.sql.Timestamp;

import lombok.Data;

public class CollectionDto {

	@Data
	static public class RegistRequest {
		private String name;
		private String phone;
		private String address;
		private String detailAddress;
	}
	
	@Data
	static public class ReadAllDto {
	    private Integer collectionId;
	    private Timestamp requestedDate;
	    private Timestamp approvedDate;
	    private Timestamp completedDate;
	    private Float weight;
	    private String image1;
	    private String image2;
	    private String image3;
	    private String image4;
	    private String resultImage1;
	    private String resultImage2;
	    private String resultImage3;
	    private String resultImage4;
	    private String inspectionResult;
	    private String address;
	    private Integer userId;
	    private String userRealName;
	}

}
