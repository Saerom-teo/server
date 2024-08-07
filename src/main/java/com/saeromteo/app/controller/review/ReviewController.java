package com.saeromteo.app.controller.review;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.saeromteo.app.dto.review.ReviewDetailDto;
import com.saeromteo.app.dto.review.ReviewDto.ReviewRequest;
import com.saeromteo.app.dto.review.ReviewDto.ReviewResponse;
import com.saeromteo.app.jwt.JWTUtil;
import com.saeromteo.app.service.review.ReviewService;

//@Controller
@RestController
@RequestMapping("/review")
public class ReviewController {

	@Autowired
	ReviewService reviewService;
	
	@Autowired
	JWTUtil jwtUtil;
	
	//Read
	@GetMapping(value = "/readProductReview/{productCode}", produces = "application/json")
	public List<ReviewDetailDto> readProductReview(@PathVariable("productCode")String productCode){
		List<ReviewDetailDto> reviewList = reviewService.readProductReview(productCode);
		return reviewList;
	}
	@GetMapping(value = "/readDetail/{reviewId}", produces = "application/json")
	public ReviewResponse readDetail(@PathVariable("reviewId") Integer reviewId) {
		ReviewResponse reviewDetail = reviewService.readDetail(reviewId);
		return reviewDetail;
	}
	@GetMapping(value = "/readUserReview/{userCode}", produces = "application/json")
	public List<ReviewDetailDto> readUserReview(@PathVariable("userCode") Integer userCode){
		List<ReviewDetailDto> reviewList = reviewService.readUserReview(userCode);
		return reviewList;
	}
	@GetMapping(value = "/readScore/{reviewScore}", produces = "application/json")
	public List<ReviewResponse> readScore(@PathVariable("reviewScroe") Integer reviewScore){
		List<ReviewResponse> reviewList = reviewService.readScore(reviewScore);
		return reviewList;
	}
	
	//Create
	@PostMapping(value = "/insertReview", produces = "text/plain;charset=utf-8")
	public String insertReview(@ModelAttribute ReviewRequest reviewRequest, @RequestParam(value="reviewImageFile", required=false) MultipartFile reviewImageFile, HttpServletRequest request) {
		String token = jwtUtil.getJwtFromCookies(request);
		int userId = jwtUtil.getUserIdFromToken(token);
		
		int result = reviewService.insertReivew(reviewRequest, reviewImageFile, userId);
		return result+ "건 생성되었습니다.";
	}
	
	//Update
	@PutMapping(value = "/updateReview", produces = "text/plain;charset=utf-8", consumes = "application/json")
	public String updateReview(@RequestBody ReviewRequest reviewRequest) {
		int result = reviewService.updateReview(reviewRequest);
		return result + "건 수정되었습니다.";
	}
	
	//Delete
	@DeleteMapping(value = "/deleteReview/{reviewId}", produces = "text/plain;charset=utf-8")
	public String deleteReview(@PathVariable("reviewId") Integer reviewId) {
		int result = reviewService.deleteReview(reviewId);
		return result + "건 삭제되었습니다.";
	}
	
	@GetMapping(value = "/readAllPaged", produces = "application/json")
	public List<ReviewResponse> readAllPaged(@RequestParam int page, @RequestParam int size) {
		return reviewService.readAllPaged(page, size);
	}
}
