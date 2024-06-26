package com.saeromteo.app.controller.orderInquiry;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailResponse;
import com.saeromteo.app.service.orderInquiry.OrderInquiryService;


@Controller
@RequestMapping("/orderInquiry")
public class OrderInquiryController {

	
	@Autowired
	OrderInquiryService orderInquiryService;
	
	@GetMapping(value = "/list", produces = "application/json")
	public String orderInquiry(Model model) {
		List<OrderDetailResponse> orderList = orderInquiryService.readAll(1);
		model.addAttribute("orderList", orderList);
		return "orderInquiry/orderInquiry2";
	}
}
