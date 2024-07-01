package com.saeromteo.app.service.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ibm.icu.text.SimpleDateFormat;
import com.saeromteo.app.dao.review.ReviewDao;
import com.saeromteo.app.dto.review.ReviewDto.ReviewRequest;
import com.saeromteo.app.dto.review.ReviewDto.ReviewResponse;
import com.saeromteo.app.util.S3Util;

@Service
public class ReviewService {
	
	@Autowired
	ReviewDao reviewDAO;
	
	@Autowired
	S3Util s3Util;
	
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
	
	public Integer readCountScore(String productCode){
		return reviewDAO.readCountScore(productCode);
	}
	
	public double readAvgScore(String productCode){
		return reviewDAO.readAvgScore(productCode);
	}
	
	public List<ReviewResponse> readByDate(Integer standard, Integer userId){
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("standard", standard);
		map.put("userId", userId);
		return reviewDAO.readByDate(map);
	}
	
	public List<ReviewResponse> readByDateBetween(String startDate, String endDate, Integer userId){
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		startDate = sdf.format(startDate);
		endDate = sdf.format(endDate);
		
		System.out.println(startDate);
		
		map.put("startDate", startDate);
		map.put("startDate", endDate);
		map.put("userId", userId);
		return reviewDAO.readByDateBetween(map);
	}
	
	//Create
	public int insertReivew(ReviewRequest reviewRequest, MultipartFile reviewImageFile) {
		if(reviewImageFile != null) {
			reviewRequest.setReviewImage(s3Util.uploadFile(reviewImageFile, "review"));
		}
		reviewRequest.setUserCode(1);
		System.out.println(reviewRequest);
		return reviewDAO.insertReview(reviewRequest);
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
