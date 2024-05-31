package com.saeromteo.app.controller.order;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.saeromteo.app.model.order.RecipientInfoDto;

@Controller
@RequestMapping("/payments")
public class PaymentsController {
	
	@RequestMapping(value = "/sendBuyerInfo", method = RequestMethod.GET)
	public RecipientInfoDto sendBuyerInfo(RecipientInfoDto recipientInfoDto) {
		return recipientInfoDto;
	}
	
//	@RequestMapping(value = "/sendOrderProduct", method = RequestMethod.GET)
//	public OrderSuccessDto sendOrderProduct(RecipientInfoDto recipientInfoDto) {
//		return recipientInfoDto;
//	}
	
	@RequestMapping(value = "/execute", method = RequestMethod.GET)
	public String execute() {
		System.out.println("결제페이지!");
		return "payments/portoneTest";
	}
	
	@RequestMapping("/kakaoPay")
	public void kakaopay() {
		System.out.println("결제성공"); 
	}
	
	@RequestMapping("/naverPay")
	public void naverPay() {
		System.out.println("결제성공"); 
	}
	
	@RequestMapping("/creditCard")
	public void creditcard() {
		System.out.println("결제성공"); 
	}

	
}
