package com.saeromteo.app.service.orderInquiry;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.orderInquiry.OrderInquiryDao;
import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailResponse;

@Service
public class OrderInquiryService {
	
	@Autowired
	private OrderInquiryDao orderInquiryDao;
	
	public List<OrderDetailResponse> readAll(int userCode) {
		List<OrderDetailResponse> orderList = orderInquiryDao.readAll(userCode);
		Map<String, OrderDetailResponse> orderMap = new HashMap<>();

        for (OrderDetailResponse orderDetail : orderList) {
            String orderCode = orderDetail.getOrder().getOrderCode();
            if (orderMap.containsKey(orderCode)) {
                OrderDetailResponse existingOrderDetail = orderMap.get(orderCode);
                existingOrderDetail.getProducts().addAll(orderDetail.getProducts());
            } else {
                orderMap.put(orderCode,orderDetail);
            }
        }

        return new ArrayList<>(orderMap.values());
	
	}

}
