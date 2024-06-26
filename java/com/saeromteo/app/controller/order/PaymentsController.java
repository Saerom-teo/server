package com.saeromteo.app.controller.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailRequest;
import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailResponse;
import com.saeromteo.app.model.order.RecipientInfoDto;
import com.saeromteo.app.service.order.OrderService;
import com.saeromteo.app.service.order.PaymentService;

@Controller
@RequestMapping("/payments")
public class PaymentsController {

	@Autowired
	private PaymentService paymentService;

	@Autowired
	private OrderService orderService;


	@RequestMapping(value = "/setOrderInfoForPay", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> setOrderInfoForPay(@RequestBody OrderDetailResponse orderDetailDto) {
		Map<String, Object> response = paymentService.setOrderInfoForPay(orderDetailDto);
		return ResponseEntity.ok(response);
	}


	@RequestMapping(value = "/execute", method = RequestMethod.GET)
	public String execute() {
		System.out.println("!");
		return "order/orderpage";
	}

	@RequestMapping("/kakaoPay")
	public void kakaopay() {
		System.out.println("카카오페이");
	}

	@RequestMapping("/naverPay")
	public void naverPay() {
		System.out.println("");
	}

	@RequestMapping("/creditCard")
	public void creditcard() {
		System.out.println("일반카드결제");
	}

}
