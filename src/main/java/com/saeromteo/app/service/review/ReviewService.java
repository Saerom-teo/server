package com.saeromteo.app.service.review;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.review.ReviewDAO;
import com.saeromteo.app.dto.review.ReviewDTO.ReviewRequest;
import com.saeromteo.app.dto.review.ReviewDTO.ReviewResponse;

@Service
public class ReviewService {
	
	@Autowired
	ReviewDAO reviewDAO;
	
	//Read
	public List<ReviewResponse> readProductReview(String productCode) {
		return reviewDAO.readProductReview(productCode);
	}
	
	public ReviewResponse readDetail(int reviewId) {
		return reviewDAO.readDetail(reviewId);
	}
	
	public List<ReviewResponse> readUserReview(int userCode) {
		return reviewDAO.readUserReview(userCode);
	}
	
	public List<ReviewResponse> readScore(int reviewScore){
		return reviewDAO.readScore(reviewScore);
	}
	
	//Create
	public int insertReivew(ReviewRequest reviewId) {
		return reviewDAO.insertReview(reviewId);
	}
	
	//Update
	public int updateReview(ReviewRequest reviewId) {
		return reviewDAO.updateReview(reviewId);
	}
	
	//Delete
	public int deleteReview(int reviewId) {
		return reviewDAO.deleteReview(reviewId);
	}
	
	public List<ReviewResponse> readAllPaged(int page, int size) {
		int offset = (page - 1) * size;
		return reviewDAO.readAllPaged(offset, size);
	}
}
