package com.saeromteo.app.controller.review;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.saeromteo.app.controller.mypage.MyPageController;
import com.saeromteo.app.dto.review.ReviewDetailDto;
import com.saeromteo.app.dto.review.ReviewDto.ReviewResponse;
import com.saeromteo.app.jwt.JWTUtil;
import com.saeromteo.app.model.product.ProductEntity;
import com.saeromteo.app.service.product.ProductService;
import com.saeromteo.app.service.review.ReviewService;
import com.saeromteo.app.service.user.UserService;

@Controller
@RequestMapping("/review")
public class ReviewFrontController {
	
	@Autowired
	ReviewService reviewService;
	
	@Autowired
	ProductService productService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	JWTUtil jwtUtil;
	
	@Autowired
	MyPageController myPageController;
	
	@GetMapping
	 public String mypage(Model model, HttpServletRequest request) {
		String token = jwtUtil.getJwtFromCookies(request);
		int userId = jwtUtil.getUserIdFromToken(token);
		List<ReviewDetailDto> reviewDetailList = reviewService.readUserReview(userId);
		
		myPageController.getMypageInfo(model, userId);
		
		model.addAttribute("reviewList", reviewDetailList);
		return "review/review";
	}
	
	@GetMapping("/{standard}")
	public String mypage(@PathVariable("standard") Integer standard, Model model, HttpServletRequest request) {
		String token = jwtUtil.getJwtFromCookies(request);
		int userId = jwtUtil.getUserIdFromToken(token);
		List<ReviewDetailDto> reviewDetailList = reviewService.readByDate(standard, userId);
		
		model.addAttribute("reviewList", reviewDetailList);
		myPageController.getMypageInfo(model, userId);
		
		return "review/review";
	}
	
	@GetMapping("/{startdate}/{enddate}")
	public String mypage(@PathVariable("startdate") String startdate, @PathVariable("enddate") String enddate, Model model, HttpServletRequest request) {
		String token = jwtUtil.getJwtFromCookies(request);
		int userId = jwtUtil.getUserIdFromToken(token);
		List<ReviewDetailDto> reviewDetailList =reviewService.readByDateBetween(startdate, enddate, userId);
		
		myPageController.getMypageInfo(model, userId);
		model.addAttribute("reviewList", reviewDetailList);
		
		
		return "review/review";
	}
}
