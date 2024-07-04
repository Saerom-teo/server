package com.saeromteo.app.service.review;

import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ibm.icu.text.SimpleDateFormat;
import com.saeromteo.app.dao.review.ReviewDao;
import com.saeromteo.app.dto.review.ReviewDateDto;
import com.saeromteo.app.dto.review.ReviewDetailDto;
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
	public List<ReviewDetailDto> readAll() {
		return reviewDAO.readAll();
	}
	
	public int readIsOrder(String productCode, int userId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("productCode", productCode);
		map.put("userId", userId);
		
		return reviewDAO.readIsOrder(map);
	}
	
	public List<ReviewDetailDto> readProductReview(String productCode) {
		return reviewDAO.readProductReview(productCode);
	}
	
	public ReviewResponse readDetail(int reviewId) {
		return reviewDAO.readDetail(reviewId);
	}
	
	public List<ReviewDetailDto> readUserReview(int userCode) {
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
	
	public List<ReviewDetailDto> readByDate(Integer standard, Integer userId){
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("standard", standard);
		map.put("userId", userId);
		return reviewDAO.readByDate(map);
	}
	
	public List<ReviewDetailDto> readByDateBetween(String startDate, String endDate, Integer userId){
		
		ReviewDateDto dto = new ReviewDateDto();
		
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		Date startDateFormat;
		try {
			startDateFormat = sdf1.parse(startDate);
			Date endDateFormat = sdf1.parse(endDate);
			
			Calendar calendar = Calendar.getInstance();
	         calendar.setTime(startDateFormat);
	         calendar.set(Calendar.HOUR_OF_DAY, 0); 
	         calendar.set(Calendar.MINUTE, 0);
	         calendar.set(Calendar.SECOND, 0);
	         
	         dto.setStartDate(sdf2.format(calendar.getTime()));
	         
	         calendar.setTime(endDateFormat);
	         calendar.set(Calendar.HOUR_OF_DAY, 0);
	         calendar.set(Calendar.MINUTE, 0);
	         calendar.set(Calendar.SECOND, 0);
			
	         dto.setEndDate(sdf2.format(calendar.getTime()));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		dto.setUserId(userId);
		return reviewDAO.readByDateBetween(dto);
	}
	
	//Create
	public int insertReivew(ReviewRequest reviewRequest, MultipartFile reviewImageFile, int userId) {
		if(reviewImageFile != null) {
			reviewRequest.setReviewImage(s3Util.uploadFile(reviewImageFile, "review"));
		}
		reviewRequest.setUserCode(userId);
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
