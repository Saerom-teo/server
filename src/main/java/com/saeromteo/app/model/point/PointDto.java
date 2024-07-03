package com.saeromteo.app.model.point;

import java.sql.Timestamp;

import com.saeromteo.app.model.collection.CollectionDto;

import lombok.Data;

public class PointDto {

	@Data
	static public class PointResponse {
		private int pointId;
		private int amount;
		private String accrualType;
		private Timestamp dateIssued;
	}
	
	@Data
	static public class PointUpdateResponse {
		private int pointId;
		private int amount;
		private String source;
		private String comment;
	}
}
