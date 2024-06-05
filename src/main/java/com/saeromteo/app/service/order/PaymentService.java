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
	 * �޼ҵ��   : processOrderInfo
	 * ����    	: ���� ������ ������ �ֹ� �� �ֹ��� ���� �غ� 
	 * 
	 * @return Map<String, Object> : /payments/buyerOrderInfo�� �����ϱ� ���� orderCode
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
        stockCheck(convertMapToDto(products));
        orderService.updateOrderStatus(orderCode, "PAYMENT_PREPARING");
        	
        return response;
    }
	
	public int stockCheck(List<OrderProductRequest> orderProduct) {
		return 0;
		
	}
	
	
	public List<OrderProductRequest> convertMapToDto(List<Map<String, Object>> mapOrderProducts) {
		List<OrderProductRequest> orderProducts = new ArrayList<>();
		for (Map<String, Object> product : mapOrderProducts) {
            OrderProductRequest orderProductRequest = new OrderProductRequest();
            orderProductRequest.setProductCode((Integer) product.get("productCode"));
            orderProductRequest.setOrderQuantity((Integer) product.get("orderQuantity"));
            orderProductRequest.setProductPrice((Integer) product.get("productPrice"));
            orderProductRequest.setOrderCode((String) product.get("orderCode"));
            
            orderProducts.add(orderProductRequest);
        }
		return orderProducts;
	}
	
	/**
	 * �޼ҵ��   : calculateTotalProductPrice
	 * ����    	: ��ǰ �ݾ� �ջ�
	 * 
	 * @return int : ��ǰ �ݾ�
	 */
	public int calculateTotalProductPrice(List<Map<String, Object>> products) {
        return products.stream()
                .mapToInt(p -> (int) p.get("price") * (int) p.get("quantity"))
                .sum();
    }

	/**
	 * �޼ҵ��   : calculateShippingCost
	 * ����    	: ��ۺ� ��� 
	 * 
	 * @return int : ��ۺ� 
	 */
    public int calculateShippingCost(int totalProductPrice) {
        return totalProductPrice >= 50000 ? 0 : 3000; // ����: 50,000�� �̻� ���� �� ���� ���
    }

    /**
	 * �޼ҵ��   : calculateTotalAmount
	 * ����    	: �� ���� �ݾ� ���
	 * 
	 * @return int : ��ǰ �ݾ� + ��ۺ� + ���� ���� �ݾ�
	 */
    public int calculateTotalAmount(int totalProductPrice, int shippingCost, int pointUsage) {
        return totalProductPrice + shippingCost - pointUsage;
    }

    public String getProductText(Map<String, Object> requestBody) {
        String firstProductName = (String) requestBody.get("firstProductName");
        int productCount = (int) requestBody.get("productCount");
        return firstProductName + " �� " + productCount + "��";
    }
    
    

}
