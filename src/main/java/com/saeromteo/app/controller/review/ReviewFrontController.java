package com.saeromteo.app.controller.review;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.saeromteo.app.dto.review.ReviewDto;
import com.saeromteo.app.service.review.ReviewService;

@Controller
@RequestMapping("/review")
public class ReviewFrontController {
	
	@Autowired
	ReviewService reviewService;
	
	@GetMapping
	 public String mypage(Model model) {
		List<ReviewDto.ReviewResponse> reviewList = reviewService.readUserReview(1);
		model.addAttribute("reviewList", reviewList);
		
		return "review/review";
	}
}
