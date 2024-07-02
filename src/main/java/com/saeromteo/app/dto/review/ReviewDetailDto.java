package com.saeromteo.app.dto.review;

import com.saeromteo.app.dto.review.ReviewDto.ReviewResponse;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewDetailDto extends ReviewResponse {
	String userName;
	String productImage;
	String productName;
	
	public ReviewDetailDto(ReviewResponse response) {
		this.reviewId = response.reviewId; 
		this.writeDate = response.writeDate;
		this.reviewContent = response.reviewContent;
		this.reviewScore = response.reviewScore;
		this.reviewImage = response.reviewImage;
		this.productCode = response.productCode;
		this.userCode = response.userCode;
	}
}
