package com.saeromteo.app.controller.order;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller	
@RequestMapping("/payments")
public class paymentsController {
	
	
	@RequestMapping(value = "/execute", method = RequestMethod.GET)
	public String exectue() {
	
		return "payments/portoneTest";
	}
	
	@RequestMapping("/kakaoPay")
	public void kakaopay() {
		System.out.println("搬力己傍"); 
	}
	
	@RequestMapping("/naverPay")
	public void naverPay() {
		System.out.println("搬力己傍"); 
	}
	
	@RequestMapping("/creditCard")
	public void creditcard() {
		System.out.println("搬力己傍"); 
	}
	
	
	
	
}
