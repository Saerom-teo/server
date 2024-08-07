package com.saeromteo.app.controller.orderInquiry;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.saeromteo.app.jwt.JWTUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailResponse;
import com.saeromteo.app.model.order.DetailInquiryDto;
import com.saeromteo.app.service.orderInquiry.OrderInquiryService;


@Controller
@RequestMapping("/orderInquiry")
public class OrderInquiryController {

	
	@Autowired
	OrderInquiryService orderInquiryService;
	
	@Autowired
	JWTUtil jwtUtil;
	
	
	@GetMapping(value = "/list", produces = "application/json")
	public String orderInquiry(Model model,HttpServletRequest request) {
		String token = jwtUtil.getJwtFromCookies(request);
        int userCode = jwtUtil.getUserIdFromToken(token);
		List<OrderDetailResponse> orderList = orderInquiryService.readAll(userCode);
		model.addAttribute("orderList", orderList);
		return "orderInquiry/orderInquiry";
	}
	
	@GetMapping(value = "/byPeriod", produces = "application/json")
	@ResponseBody
	public List<OrderDetailResponse> orderInquiryByPeriod(@RequestParam String start,@RequestParam String end, Model model,HttpServletRequest request) {
		String token = jwtUtil.getJwtFromCookies(request);
        int userCode = jwtUtil.getUserIdFromToken(token);
		Date startDate = orderInquiryService.calculateStartDate(start);
		Date endDate = orderInquiryService.calculateEndDate(end);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<OrderDetailResponse> orderList = orderInquiryService.readByPeriod(userCode, sdf.format(startDate), sdf.format(endDate));
        return orderList; 
	}
	
	@GetMapping(value= "/orderDetail", produces = "application/json")
	public String orderDetailInquiry(@RequestParam String orderCode, Model model){
		List<DetailInquiryDto> orderDetailInquiry= orderInquiryService.readDetailInquiry(orderCode);
		model.addAttribute("orderDetailInquiry", orderDetailInquiry);
		return "orderInquiry/orderDetailnquriy";
	}
	
	
	

}
