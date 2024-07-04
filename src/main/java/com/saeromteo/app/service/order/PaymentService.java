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
import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailResponse;
import com.saeromteo.app.model.order.OrderProductDto.OrderProductRequest;
import com.saeromteo.app.model.order.OrderProductDto.OrderProductResponse;

@Service
public class PaymentService {
	
	@Autowired
	private PaymentDao paymentDao;
	
	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private OrderService orderService;

	
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
	

    

}
