package com.saeromteo.app.service.orderInquiry;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.orderInquiry.OrderInquiryDao;
import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailResponse;

@Service
public class OrderInquiryService {
	
	@Autowired
	private OrderInquiryDao orderInquiryDao;
	
	public List<OrderDetailResponse> readAll(int userCode) {
		return orderInquiryDao.readAll(userCode);
	}

}
