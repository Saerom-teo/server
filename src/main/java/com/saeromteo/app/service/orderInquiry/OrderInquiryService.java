package com.saeromteo.app.service.orderInquiry;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
				orderMap.put(orderCode, orderDetail);
			}
		}

		return new ArrayList<>(orderMap.values());

	}

	public List<OrderDetailResponse> readByPeriod(int userCode, String startDate, String endDate) {
		return orderInquiryDao.readByPeriod(userCode, startDate, endDate);
	}

	public Date calculateStartDate(String period) {
		Calendar cal = Calendar.getInstance();
		switch (period) {
		case "_1-year":
			cal.add(Calendar.YEAR, -1);
			break;
		case "_3-months":
			cal.add(Calendar.MONTH, -3);
			break;
		case "_1-month":
			cal.add(Calendar.MONTH, -1);
			break;
		case "_1-week":
			cal.add(Calendar.WEEK_OF_YEAR, -1);
			break;
		default:
			cal.add(Calendar.YEAR, -1);
		}
		return cal.getTime();

	}
}
