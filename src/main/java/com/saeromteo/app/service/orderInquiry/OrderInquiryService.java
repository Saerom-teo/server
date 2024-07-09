package com.saeromteo.app.service.orderInquiry;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.orderInquiry.OrderInquiryDao;
import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailResponse;
import com.saeromteo.app.model.order.DetailInquiryDto;

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
	
	public List<DetailInquiryDto> readDetailInquiry(String orderCode){
		List<DetailInquiryDto> orderDetails= orderInquiryDao.readDetailInquiry(orderCode);	
		for (DetailInquiryDto orderDetail : orderDetails) {
			String orderStatus = orderDetail.getOrderStatus();
			if(orderStatus.equals("PAYMENT_COMPLETED")) {
				orderDetail.setOrderStatus("주문 완료");
			}
			else if(orderStatus.equals("SHIPPING")) {
				orderDetail.setOrderStatus("배송중");
			} else if(orderStatus.equals("DELIVERED")) {
				orderDetail.setOrderStatus("배송완료");
			} else if(orderStatus.equals("LAST_CANCELLED")) {
				orderDetail.setOrderStatus("주문취소 완료");
			} 
		}
		return orderDetails;
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
	
    public Date calculateStartDate2(String type) {
        Calendar cal = Calendar.getInstance();
        switch (type) {
            case "week":
                cal.add(Calendar.WEEK_OF_YEAR, -1);
                break;
            case "one-month":
                cal.add(Calendar.MONTH, -1);
                break;
            case "three-month":
                cal.add(Calendar.MONTH, -3);
                break;
            default:
                cal.set(Calendar.YEAR, 2000); // 적절한 기본 시작 날짜 설정
        }
        return cal.getTime();
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
	
	
	/**
	 * 메소드명   : combineOrders
	 * 설명    	: 상품 단위 -> 주문 단위로 합병 
	 * 
	 * @return 
	 */
	private List<OrderDetailResponse> combineOrders(List<OrderDetailResponse> orderList){
		
		Map<String, OrderDetailResponse> orderMap = new LinkedHashMap<>();
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
