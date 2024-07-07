package com.saeromteo.app.controller.mypage;

import java.util.ArrayList;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.saeromteo.app.jwt.JWTUtil;
import com.saeromteo.app.model.order.DetailInquiryDto;
import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailResponse;
import com.saeromteo.app.model.point.PointDto.PointResponse;
import com.saeromteo.app.model.user.UserDTO;
import com.saeromteo.app.service.collection.CollectionService;
import com.saeromteo.app.service.orderInquiry.OrderInquiryService;
import com.saeromteo.app.service.point.PointService;
import com.saeromteo.app.service.user.UserService;
import com.saeromteo.app.util.RankUtil;

import io.swagger.annotations.Api;
import springfox.documentation.annotations.ApiIgnore;

@Controller
@RequestMapping("/mypage")
@Api(tags = "Mypage Management")
public class MyPageController {

	@Autowired
	CollectionService collectionService;

	@Autowired
	PointService pointService;

	@Autowired
	UserService userService;

	@Autowired
	OrderInquiryService orderInquiryService;

	@Autowired
	JWTUtil jwtUtil;

	@Autowired
	RankUtil rankUtil;

	// ================================================
	// Collection
	// ================================================

	@GetMapping("/collection")
	@ApiIgnore
	public String collection(Model model, HttpServletRequest request) {
		String token = jwtUtil.getJwtFromCookies(request);
		int userId = jwtUtil.getUserIdFromToken(token);

		getMypageInfo(model, userId);
		return "mypage/mypage-collection";
	}

	@GetMapping("/collection/cancel")
	@ApiIgnore
	public String collectionCancel(@RequestParam("collectionId") Integer collectionId) {
		collectionService.cancelCollection(collectionId);
		return "redirect:/mypage/collection";
	}

	// ================================================
	// Point
	// ================================================

	@GetMapping("/point")
	@ApiIgnore
	public String point(Model model, @RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "10") int size, @RequestParam(defaultValue = "all") String type,
			HttpServletRequest request) {
		String token = jwtUtil.getJwtFromCookies(request);
		int userId = jwtUtil.getUserIdFromToken(token);
		if ("all".equals(type)) {
			type = null; // type이 'all'이면 null로 처리하여 모든 데이터를 조회
		}
		List<PointResponse> pointResponses = pointService.getPointsByUserId(userId, page, size, type);
		int totalPoints = pointService.getTotalPointsByUserId(userId, type); // 총 포인트 수를 가져오는 메서드
		int totalPages = (int) Math.ceil((double) totalPoints / size);

		model.addAttribute("pointResponses", pointResponses);
		model.addAttribute("currentPage", page);
		model.addAttribute("pageSize", size);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("currentType", type); // 현재 타입을 전달
		
		getMypageInfo(model, userId);
		
		return "mypage/mypage-point";
	}

	// ================================================
	// Order
	// ================================================

	@GetMapping("/order")
	@ApiIgnore
	public String order(Model model, @RequestParam(defaultValue = "all") String type,
			@RequestParam(required = false) String startDate, @RequestParam(required = false) String endDate,
			HttpServletRequest request) {
		String token = jwtUtil.getJwtFromCookies(request);
		int userId = jwtUtil.getUserIdFromToken(token);

		List<OrderDetailResponse> orderList = new ArrayList<>();

		if (type.equals("all")) {
			orderList = orderInquiryService.readAll(userId);
		} else if ("custom".equals(type) && startDate != null && endDate != null) {
			orderList = orderInquiryService.readByPeriod(userId, startDate, endDate);
		} else {
			// 특정 기간의 시작 날짜와 종료 날짜를 계산
			Date calculatedStartDate = orderInquiryService.calculateStartDate2(type);
			Date calculatedEndDate = new Date(); // 현재 날짜
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			String formattedStartDate = dateFormat.format(calculatedStartDate);
			String formattedEndDate = dateFormat.format(calculatedEndDate);
			orderList = orderInquiryService.readByPeriod(userId, formattedStartDate, formattedEndDate);
		}

		model.addAttribute("orderList", orderList);
		model.addAttribute("currentType", type);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		getMypageInfo(model, jwtUtil.getUserIdFromToken(token));

		return "mypage/mypage-order-list";
	}

	@GetMapping("/order-detail/{orderCode}")
	@ApiIgnore
	public String orderDetail(Model model, HttpServletRequest request, @PathVariable("orderCode") String orderCode) {
		String token = jwtUtil.getJwtFromCookies(request);
		int userId = jwtUtil.getUserIdFromToken(token);

		List<DetailInquiryDto> orderDetailInquiry = orderInquiryService.readDetailInquiry(orderCode);

		model.addAttribute("orderDetailInquiry", orderDetailInquiry);
		getMypageInfo(model, userId);

		return "mypage/mypage-order-detail";
	}

	@GetMapping("/order-return/{orderCode}")
	@ApiIgnore
	public String orderReturn(Model model, HttpServletRequest request, @PathVariable("orderCode") String orderCode) {
		String token = jwtUtil.getJwtFromCookies(request);
		int userId = jwtUtil.getUserIdFromToken(token);

		List<DetailInquiryDto> orderDetailInquiry = orderInquiryService.readDetailInquiry(orderCode);

		model.addAttribute("orderDetailInquiry", orderDetailInquiry);
		getMypageInfo(model, userId);

		return "mypage/mypage-order-return";
	}

	// ================================================
	// ETC
	// ================================================

	public void getMypageInfo(Model model, int userId) {
		UserDTO user = userService.readUserByUserId(userId);

		String nickname = user.getUserNickname();
		String profileImg = user.getUserImgPath();
		int point = user.getUserPointHistory();
		String rank = rankUtil.calcRank(userId);

		model.addAttribute("nickname", nickname);
		model.addAttribute("profileImg", profileImg);
		model.addAttribute("point", point);
		model.addAttribute("rank", rank);
		model.addAttribute("rankImg", rankUtil.getRankImage(rank));
	}

}