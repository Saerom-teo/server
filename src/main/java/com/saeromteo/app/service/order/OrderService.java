package com.saeromteo.app.service.order;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.saeromteo.app.util.DateUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.saeromteo.app.dao.order.OrderDao;
import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailResponse;
import com.saeromteo.app.model.order.OrderDetailDto;
import com.saeromteo.app.model.order.OrderDto;
import com.saeromteo.app.model.order.OrderDto.OrderRequest;
import com.saeromteo.app.model.order.OrderEntity;
import com.saeromteo.app.model.order.OrderProductDto.OrderProductRequest;
import com.saeromteo.app.model.order.OrderProductEntity;

@Service
public class OrderService {

	@Autowired
	private OrderDao orderDao;
	
	/**
	 * 메소드명   : createOrder
	 * 설명    	: orderDto를 사용하여 orderEntity 생성 
	 * 
	 * @return String : orderProductEntity에 전달하기 위한 orderCode
	 */
	@Transactional
	public String createOrder(OrderRequest orderDto) {
		OrderEntity orderEntity = convertToEntity(orderDto);
		orderDao.createOrder(orderEntity);
		return orderEntity.getOrderCode();
	}
	
	/**
	 * 메소드명   : createOrderProducts
	 * 설명    	: productDtos,orderCode를 사용하여 orderProductEntity 생성 
	 * 
	 * @return void 
	 */
	@Transactional
	public void createOrderProducts(List<OrderProductRequest> productDtos, String orderCode) {
        for (OrderProductRequest productDto : productDtos) {
            OrderProductEntity orderProductEntity = convertToEntity(productDto);
            orderProductEntity.setOrderCode(orderCode);
            orderDao.createOrderProduct(orderProductEntity);
        }
    }
	
	/**
	 * 메소드명   : updateOrderStatus
	 * 설명    	: 주문 상태 현황 업데이트
	 * 
	 * @return void
	 */
	
	@Transactional
	public void updateOrderStatus(String orderCode, String orderStatus) {
		Map<String, String> orderStatusInfo = new HashMap<>();
		orderStatusInfo.put("orderCode", orderCode);
		orderStatusInfo.put("orderStatus", orderStatus);
        orderDao.updateOrderStatus(orderStatusInfo);
		
	}
	
	public List<OrderDetailResponse> readAll(){
		return orderDao.readAll();
	}

	public List<OrderDetailResponse> readByUser(int userCode){
		return orderDao.readByUser(userCode);
	}
	
	private OrderEntity convertToEntity(OrderRequest orderDto) {
	    OrderEntity orderEntity = new OrderEntity();
	    setOrderFields(orderEntity, orderDto);
	    return orderEntity;
	}

	
	private OrderProductEntity convertToEntity(OrderProductRequest orderProductDto) {
	    OrderProductEntity orderProductEntity = new OrderProductEntity();
	    setProductFields(orderProductEntity, orderProductDto);
	    return orderProductEntity;
	}
	
	/**
	 * 메소드명   : setOrderFields
	 * 설명    	: EntityField 를 설정하고 OrderCode는 함수를 통해서 삽입
	 * 
	 * @return void 
	 */
	private void setOrderFields(OrderEntity orderEntity, OrderRequest orderDto) {
        if (orderDto.getOrderCode() == null) {
            orderEntity.setOrderCode(generateOrderCode(orderDto.getOrderDate(), orderDto.getUserCode()));
        } else {
            orderEntity.setOrderCode(orderDto.getOrderCode());
        }
        orderEntity.setOrderDate(DateUtil.localDateTimeToTimeStamp(LocalDateTime.now())); 
        orderEntity.setOrderStatus(orderDto.getOrderStatus());
        
        //test용 
        orderEntity.setUserCode(orderDto.getUserCode());
    }
	private void setProductFields(OrderProductEntity orderProductEntity, OrderProductRequest orderProductDto) {
	    orderProductEntity.setProductCode(orderProductDto.getProductCode());
	    orderProductEntity.setOrderQuantity(orderProductDto.getOrderQuantity());
	    orderProductEntity.setProductPrice(orderProductDto.getProductPrice());
	}
	
	/**
	 * 메소드명   : generateOrderCode
	 * 설명    	: orderDate + userCode 조합으로 orderCode 생성
	 * 
	 * @return String : 생성된 orderCode
	 */
	private String generateOrderCode(LocalDateTime orderDate, int userCode) {
       
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMddHHmmss");
        return orderDate.format(formatter) + "-" + userCode;
    }
	
	

}
