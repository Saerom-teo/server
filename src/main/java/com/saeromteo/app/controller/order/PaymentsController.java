package com.saeromteo.app.controller.order;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@Controller
@RequestMapping("/payments")
public class PaymentsController {
	
	
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
