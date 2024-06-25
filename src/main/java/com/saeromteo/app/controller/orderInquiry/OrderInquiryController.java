package com.saeromteo.app.controller.orderInquiry;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/orderInquiry")
public class OrderInquiryController {

	@GetMapping("/list")
	public String orderInquiry() {
		return "orderInquiry/orderInquiry";
	}
}
