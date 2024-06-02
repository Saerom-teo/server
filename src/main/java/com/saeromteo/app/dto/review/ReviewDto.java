package com.saeromteo.app.dto.review;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

public class ReviewDto {
	
	@Getter
	@Setter
	@ToString
	public static class ReviewRequest{
		int reviewId;
		Date writeDate;
		String reviewContent;
		int reviewScore;
		String reviewImage;
		int productCode;
		int userCode;
	}
	
	@Getter
	@Setter
	@ToString
	public static class ReviewRespose{
		int reviewId;
		Date writeDate;
		String reviewContent;
		int reviewScore;
		String reviewImage;
		int productCode;
		int userCode;
	}
}
