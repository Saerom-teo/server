package com.saeromteo.app.service.review;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.review.ReviewDao;
import com.saeromteo.app.dto.review.ReviewDto.ReviewRequest;
import com.saeromteo.app.dto.review.ReviewDto.ReviewResponse;

@Service
public class ReviewService {
	
	@Autowired
	ReviewDao reviewDao;
	
	//Read
	public List<ReviewResponse> readProductReview(String productCode) {
		return reviewDao.readProductReview(productCode);
	}
	
	public ReviewResponse readDetail(int reviewId) {
		return reviewDao.readDetail(reviewId);
	}
	
	public List<ReviewResponse> readUserReview(int userCode) {
		return reviewDao.readUserReview(userCode);
	}
	
	public List<ReviewResponse> readScore(int reviewScore){
		return reviewDao.readScore(reviewScore);
	}
	
	//Create
	public int insertReivew(ReviewRequest reviewId) {
		return reviewDao.insertReivew(reviewId);
	}
	
	//Update
	public int updateReview(ReviewRequest reviewId) {
		return reviewDao.updateReview(reviewId);
	}
	
	//Delete
	public int deleteReview(int reviewId) {
		return reviewDao.deleteReview(reviewId);
	}
	
	public List<ReviewResponse> readAllPaged(int page, int size) {
		int offset = (page - 1) * size;
		return reviewDao.readAllPaged(offset, size);
	}
}
