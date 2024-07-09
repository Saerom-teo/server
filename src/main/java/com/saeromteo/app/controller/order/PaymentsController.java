package com.saeromteo.app.controller.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailRequest;
import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailResponse;
import com.saeromteo.app.model.order.OrderProductDto;
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

	@PostMapping("/checkStock")
    public ResponseEntity<Map<String, Object>> checkStock(@RequestBody List<OrderProductDto.OrderProductRequest> products,HttpServletRequest request) {
        boolean stockAvailable = orderService.stockCheck(products);
        HttpSession session = request.getSession();
        String orderCode = (String) session.getAttribute("orderCode");
        Map<String, Object> response = new HashMap<>();
        response.put("stockAvailable", stockAvailable);
        if(stockAvailable == true) {
        	orderService.updateOrderStatus(orderCode, "PAYMENT_PREPARING");
        }
        else {
        	orderService.updateOrderStatus(orderCode, "ORDER_FAILED");
        }
        return ResponseEntity.ok(response);
    }
	

}
