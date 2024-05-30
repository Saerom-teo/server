package com.saeromteo.app.controller.order;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailResponse;
import com.saeromteo.app.model.order.OrderDto.OrderRequest;
import com.saeromteo.app.model.order.OrderProductDto.OrderProductRequest;
import com.saeromteo.app.service.order.OrderService;

@RestController
@RequestMapping("/order")
public class OrderController {

	@Autowired
	OrderService orderService;

	// Create

	
	@PostMapping(value = "/createOrderWithProducts", consumes = "application/json", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> createOrderWithProducts(@RequestBody OrderRequest orderDto, @RequestBody List<OrderProductRequest> productDtos) {
	    String orderCode = orderService.createOrder(orderDto);
	    if (productDtos != null && !productDtos.isEmpty()) {
	        orderService.createOrderProducts(productDtos, orderCode);
	    }
	    return ResponseEntity.status(HttpStatus.CREATED).body(orderCode);
	}

	
	

	// Read
	@GetMapping(value = "/readAll", produces = "application/json")
	public List<OrderDetailResponse> readAll(){
		List<OrderDetailResponse> orderDetailList = orderService.readAll();
		return orderDetailList;
	}
	
	@GetMapping(value = "/readByUser", produces = "application/json")
	public List<OrderDetailResponse> readByUser(@RequestParam int userCode) {
		List<OrderDetailResponse> orderDetailList = orderService.readByUser(userCode);
		return orderDetailList;
	}

}
