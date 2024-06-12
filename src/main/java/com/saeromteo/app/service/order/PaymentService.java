package com.saeromteo.app.service.order;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.saeromteo.app.dao.order.OrderDao;
import com.saeromteo.app.dao.order.PaymentDao;
import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailRequest;
import com.saeromteo.app.model.order.OrderProductDto.OrderProductRequest;

@Service
public class PaymentService {
	
	@Autowired
	private PaymentDao paymentDao;
	
	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private OrderService orderService;

	
	/**
	 * 메소드명   : processOrderInfo
	 * 설명    	: 결제 정보로 전달할 주문 및 주문자 내역 준비 
	 * 
	 * @return Map<String, Object> : /payments/buyerOrderInfo에 전달하기 위한 orderCode
	 */
	
	public Map<String, Object> processOrderInfo(Map<String, Object> requestBody) {
        Map<String, Object> recipientInfo = (Map<String, Object>) requestBody.get("recipientInfo");
        Map<String, Object> orderDetail = (Map<String, Object>) requestBody.get("orderDetail");
        String orderCode = (String) ((Map<String, Object>) orderDetail.get("order")).get("orderCode");

        orderService.updateOrderStatus(orderCode, "PAYMENT_REQUESTED");

        List<Map<String, Object>> products = (List<Map<String, Object>>) orderDetail.get("products");
        int totalProductPrice = calculateTotalProductPrice(products);
        int shippingCost = calculateShippingCost(totalProductPrice);
        int pointUsage = (int) requestBody.get("point");
        int totalAmount = calculateTotalAmount(totalProductPrice, shippingCost, pointUsage);
        String productText = getProductText(requestBody);

        Map<String, Object> response = new HashMap<>();
        response.put("recipientInfo", recipientInfo);
        response.put("productName", productText);
        response.put("totalAmount", totalAmount);
        orderService.stockCheck(convertMapToDto(products));
        orderService.updateOrderStatus(orderCode, "PAYMENT_PREPARING");
        	
        return response;
    }
	
	public List<OrderProductRequest> convertMapToDto(List<Map<String, Object>> mapOrderProducts) {
		List<OrderProductRequest> orderProducts = new ArrayList<>();
		for (Map<String, Object> product : mapOrderProducts) {
            OrderProductRequest orderProductRequest = new OrderProductRequest();
            orderProductRequest.setProductCode((String) product.get("productCode"));
            orderProductRequest.setOrderQuantity((Integer) product.get("orderQuantity"));
            orderProductRequest.setProductPrice((Integer) product.get("productPrice"));
            orderProductRequest.setOrderCode((String) product.get("orderCode"));
            
            orderProducts.add(orderProductRequest);
        }
		return orderProducts;
	}
	
	/**
	 * 메소드명   : calculateTotalProductPrice
	 * 설명    	: 상품 금액 합산
	 * 
	 * @return int : 상품 금액
	 */
	
	public int calculateTotalProductPrice(List<Map<String, Object>> products) {
        return products.stream()
                .mapToInt(p -> (int) p.get("price") * (int) p.get("quantity"))
                .sum();
    }

	/**
	 * 메소드명   : calculateShippingCost
	 * 설명    	: 배송비 계산 
	 * 
	 * @return int : 배송비 
	 */
	
    public int calculateShippingCost(int totalProductPrice) {
        return totalProductPrice >= 50000 ? 0 : 3000; // ����: 50,000�� �̻� ���� �� ���� ���
    }

    /**
   	 * 메소드명   : calculateTotalAmount
   	 * 설명    	: 총 결제 금액 계산
   	 * 
   	 * @return int : 상품 금액 + 배송비 + 쿠폰 계산된 금액
   	 */
    public int calculateTotalAmount(int totalProductPrice, int shippingCost, int pointUsage) {
        return totalProductPrice + shippingCost - pointUsage;
    }

    public String getProductText(Map<String, Object> requestBody) {
        String firstProductName = (String) requestBody.get("firstProductName");
        int productCount = (int) requestBody.get("productCount");
        return firstProductName + " 외 " + productCount + "건";
    }
    
    

}
