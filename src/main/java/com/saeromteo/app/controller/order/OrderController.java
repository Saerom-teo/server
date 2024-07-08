package com.saeromteo.app.controller.order;

import java.util.List;
import java.util.Map;
import com.saeromteo.app.jwt.JWTUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailRequest;
import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailResponse;
import com.saeromteo.app.model.order.OrderDto.OrderRequest;
import com.saeromteo.app.model.order.OrderDto.OrderResponse;
import com.saeromteo.app.model.order.OrderProductDto.OrderProductRequest;
import com.saeromteo.app.model.order.OrderProductDto.OrderProductResponse;
import com.saeromteo.app.model.order.RecipientInfoDto;
import com.saeromteo.app.model.order.DeliveryDto;
import com.saeromteo.app.model.order.OrderDetailDto;
import com.saeromteo.app.service.order.OrderService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
@RequestMapping("/order")
public class OrderController {

	@Autowired
	OrderService orderService;
	
	@Autowired
	JWTUtil jwtUtil;
	
	/*
	 * @Autowired DeliveryDto.DeliveryResponse deliveryInfo;
	 */

	//test
	
	@GetMapping("/cart")
    public String showCart() {
        return "order/test";
    }
	
	
	// Create
	@PostMapping(value = "/createOrderAndProducts", consumes = "application/json", produces = "application/json;charset=UTF-8")
    public ResponseEntity<String> createOrderAndProducts(@RequestBody OrderDetailRequest orderSuccessDto, HttpServletRequest request) {
		
		String token = jwtUtil.getJwtFromCookies(request);
        int userCode = jwtUtil.getUserIdFromToken(token);
		HttpSession session = request.getSession();
		
		OrderResponse orderDto = orderService.createOrder(userCode);
        String orderCode = orderDto.getOrderCode();
        if (orderSuccessDto.getProducts() != null && !orderSuccessDto.getProducts().isEmpty()) {
            orderService.createOrderProducts(orderSuccessDto.getProducts(), orderCode);
         
        }
        
        OrderDetailResponse orderDetailResponse = orderService.setOrderDetailResponse(orderDto,orderSuccessDto);
        
        // 주문 데이터 추가
        session.setAttribute("orderDetailResponse", orderDetailResponse);
        session.setAttribute("orderCode", orderCode);
        return ResponseEntity.ok("Order created successfully");
    }
	
	@GetMapping("/orderpage")
    public String showOrderPage(HttpServletRequest request,Model model) {
		
		String token = jwtUtil.getJwtFromCookies(request);
        int userCode = jwtUtil.getUserIdFromToken(token);
        
		HttpSession session = request.getSession();
	    OrderDetailResponse orderDetailResponse = (OrderDetailResponse) session.getAttribute("orderDetailResponse");
	    
		RecipientInfoDto recipientInfo = orderService.getRecipientInfo(userCode);
		int totalPoints = orderService.getTotalPoints(userCode);
		model.addAttribute("recipientInfo", recipientInfo);
		model.addAttribute("totalPoints", totalPoints);
		model.addAttribute("orderDetailRe sponse", orderDetailResponse);
        return "order/orderpage";
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
	
	//Update
	@PostMapping(value="paymentFailure", consumes = "text/plain", produces = "application/json")
	public String paymentFailure(@RequestBody String orderStatus, HttpServletRequest request){
		HttpSession session = request.getSession();
        String orderCode = (String) session.getAttribute("orderCode");
        if (orderCode != null) {
            orderService.updateOrderStatus(orderCode, orderStatus);
            return "order/afterOrder";
        } else {
            return "order/orderafterOrder";
        }
	}
	
	@PostMapping(value="paymentSuccess",consumes = "application/json", produces = "application/json")
	public @ResponseBody ResponseEntity<?> paymentSuccess(@RequestBody Map<String, String> paymentData, HttpServletRequest request) {
		

		String token = jwtUtil.getJwtFromCookies(request);
        int userCode = jwtUtil.getUserIdFromToken(token);
        
		String orderStatus = paymentData.get("orderStatus");
	    int usedPoints = Integer.parseInt(paymentData.get("usedPoints"));
	    String recipient = paymentData.get("recipientName");
	    String phoneNumber = paymentData.get("phoneNumber");
	    String address = paymentData.get("address");
	    String deliveryMemo = paymentData.get("deliveryMemo");
	    System.out.println("deliveryMemo"+deliveryMemo);
		HttpSession session = request.getSession();
        String orderCode = (String) session.getAttribute("orderCode");
        OrderDetailResponse orderDetailResponse = (OrderDetailResponse) session.getAttribute("orderDetailResponse");
        List<OrderProductResponse> products = orderDetailResponse.getProducts();
        try {
        	if(usedPoints > 0) {
        		orderService.registerPoint(userCode,usedPoints,orderCode);
        	}
        	orderService.setRecipient(recipient,phoneNumber,address,deliveryMemo,orderCode,userCode);
        	orderService.updateOrderStatus(orderCode, orderStatus);
        	return ResponseEntity.ok().body("결제 상태 업데이트 및 배송지 저장 성공");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("결제 상태 업데이트 및 배송지 저장 실패: " + e.getMessage());
        }
      
	}
	
	@GetMapping("/afterOrder")
    public String afterOrder(@RequestParam(name = "status", required = false) String status, Model model) {
        model.addAttribute("status", status);
        return "order/afterOrder";
    }

}
