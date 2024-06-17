package com.saeromteo.app.dao.review;

import java.util.List;

import com.saeromteo.app.dto.review.ReviewDto.ReviewRequest;
import com.saeromteo.app.dto.review.ReviewDto.ReviewResponse;

public interface ReviewInterface {
	
	//Read
	public List<ReviewResponse> readProductReview(String productCode);
	
	public ReviewResponse readDetail(int reviewId);
	
	public List<ReviewResponse> readUserReview(int userCode);
	
	//Create
	public int insertReivew(ReviewRequest reviewId);
	
	//Update
	public int updateReview(ReviewRequest reviewId);
	
	//Delete
	public int deleteReview(int reviewId);
	
	public List<ReviewResponse> readAllPaged(int page, int size);
}
