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
		System.out.println("����������!");
		return "payments/portoneTest";
	}
	
	@RequestMapping("/kakaoPay")
	public void kakaopay() {
		System.out.println("��������"); 
	}
	
	@RequestMapping("/naverPay")
	public void naverPay() {
		System.out.println("��������"); 
	}
	
	@RequestMapping("/creditCard")
	public void creditcard() {
		System.out.println("��������"); 
	}

	
}
