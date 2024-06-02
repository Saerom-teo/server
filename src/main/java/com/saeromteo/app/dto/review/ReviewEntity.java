package com.saeromteo.app.dto.review;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewEntity {
	int reviewId;
	Date writeDate;
	String reviewContent;
	int reviewScore;
	String reviewImage;
	String productCode;
	int userCode;
}
