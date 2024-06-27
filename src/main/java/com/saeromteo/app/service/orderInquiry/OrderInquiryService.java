package com.saeromteo.app.service.orderInquiry;

import java.text.ParseException;
import java.text.SimpleDateFormat;
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

	/**
	 * 메소드명   : readAll
	 * 설명    	: 상품별로 칼럼이 출력되기 때문에 주문 단위 OrderDetailResponse 로 묶어줌
	 * 
	 * @return  List<OrderDetailResponse> : 전체 주문 내역 
	 */
	public List<OrderDetailResponse> readAll(int userCode) {
		List<OrderDetailResponse> orderList = orderInquiryDao.readAll(userCode);
		return combineOrders(orderList);
	}

	/**
	 * 메소드명   : readByPeriod
	 * 설명    	: 시작 날짜, 종료 날짜를 받아서 기간 별로 주문 내역 조회 
	 * 
	 * @return  List<OrderDetailResponse> : 기간별 주문 내역 
	 */
	public List<OrderDetailResponse> readByPeriod(int userCode, String startDate, String endDate) {
		List<OrderDetailResponse> orderList = orderInquiryDao.readByPeriod(userCode, startDate, endDate);
		return combineOrders(orderList);
	}

	/**
	 * 메소드명   : calculateStartDate
	 * 설명    	: 클라이언트 버튼을 통해서 기간을 받아서 시작 날짜 생성 
	 * 
	 * @return 
	 */
	public Date calculateStartDate(String start) {
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date parsedDate = null;
        try {
            parsedDate = dateFormat.parse(start);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        
		Calendar startCal = Calendar.getInstance();
		startCal.setTime(parsedDate);
		startCal.set(Calendar.HOUR_OF_DAY, 0);
	    startCal.set(Calendar.MINUTE, 0);
	    startCal.set(Calendar.SECOND, 0);
	    startCal.set(Calendar.MILLISECOND, 0);
		return startCal.getTime();

	}
	
	/**
	 * 메소드명   : calculateEndDate
	 * 설명    	: 현재 날짜를 sql 구문에 맞추어 시,분,초를 더하여 포맷팅
	 * 
	 * @return 
	 */
	public Date calculateEndDate(String end) {
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date parsedDate = null;
        try {
            parsedDate = dateFormat.parse(end);
        } catch (ParseException e) {
            e.printStackTrace();
        }
       
		Calendar endCal = Calendar.getInstance();
	    endCal.setTime(parsedDate);
	    endCal.set(Calendar.HOUR_OF_DAY, 23);
	    endCal.set(Calendar.MINUTE, 59);
	    endCal.set(Calendar.SECOND, 59);
	    endCal.set(Calendar.MILLISECOND, 999);
	    return endCal.getTime();
	}
	
	private List<OrderDetailResponse> combineOrders(List<OrderDetailResponse> orderList){
		
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
	
}
