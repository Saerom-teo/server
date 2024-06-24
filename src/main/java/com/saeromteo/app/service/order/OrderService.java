package com.saeromteo.app.service.order;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.saeromteo.app.util.DateUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.saeromteo.app.dao.order.OrderDao;
import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailRequest;
import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailResponse;
import com.saeromteo.app.model.order.OrderDetailDto;
import com.saeromteo.app.model.order.OrderDto;
import com.saeromteo.app.model.order.OrderDto.OrderRequest;
import com.saeromteo.app.model.order.OrderDto.OrderResponse;
import com.saeromteo.app.model.order.OrderEntity;
import com.saeromteo.app.model.order.OrderProductDto.OrderProductRequest;
import com.saeromteo.app.model.order.OrderProductDto.OrderProductResponse;
import com.saeromteo.app.model.order.OrderProductEntity;
import com.saeromteo.app.model.order.RecipientInfoDto;

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
	public OrderResponse createOrder(int userCode) {
		OrderEntity orderEntity = convertToEntity(userCode);
		OrderResponse orderDto = setDtoOrderFields(orderEntity);

		orderDao.createOrder(orderEntity);
		return orderDto;
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

	/**
	 * 메소드명   : setOrderDetailResponse
	 * 설명    	: orderDto, orderSuccessDto를 사용하여 OrderDetailResponse 생성
	 * 
	 * @return OrderDetailResponse : 페이지 전환 시 서버로 전달해주는 값
	 */
	public OrderDetailResponse setOrderDetailResponse(OrderResponse orderDto,OrderDetailRequest orderSuccessDto) {
		OrderDetailResponse orderDetailResponse = new OrderDetailResponse();
		orderDetailResponse.setOrder(orderDto);
		List<OrderProductResponse> productResponses = orderSuccessDto.getProducts().stream()
                .map(productRequest -> convertToOrderProductResponse(productRequest, orderDto.getOrderCode()))
                .collect(Collectors.toList());
		orderDetailResponse.setProducts(productResponses);
		orderDetailResponse.setShippingPrice(orderSuccessDto.getShippingPrice());
		orderDetailResponse.setTotalOrderPrice(orderSuccessDto.getTotalOrderPrice());
		return orderDetailResponse;
	}
	
	/**
	 * 메소드명   : stockCheck
	 * 
	 * 
	 * @return boolean 주문 가능하면 true, 불가능하면 false
	 */
	public boolean stockCheck(List<OrderProductRequest> orderProduct) {
		for (OrderProductRequest product : orderProduct) {
			int productQuantity = orderDao.stockCheck(product);
			int orderQuantity = product.getOrderQuantity();
			return orderQuantity < productQuantity;
		}
		return false;
	}
	
	/**
	 * 메소드명   : getTotalPoints
	 * 
	 * 			포인트가 없을 경우 0으로 초기화(orderDao에서) 
	 * @return 포인트 값
	 */
	public int getTotalPoints(int userCode) {
		return orderDao.getTotalPoints(userCode);
	}
	
	/**
	 * 메소드명   : getRecipientInfo
	 * 
	 * 			
	 * @return 배송지 정보 
	 */
	public RecipientInfoDto getRecipientInfo(int userCode) {
		return orderDao.getRecipientInfo(userCode);
	}

	public List<OrderDetailResponse> readAll() {
		return orderDao.readAll();
	}

	public List<OrderDetailResponse> readByUser(int userCode) {
		return orderDao.readByUser(userCode);
	}
	
	


	/**
	 * 메소드명   : setEntityOrderFields
	 * 설명    	: EntityField 를 설정하고 OrderCode는 함수를 통해서 삽입
	 * 
	 * @return orderEntity
	 */
	private OrderEntity setEntityOrderFields(OrderEntity orderEntity,int userCode) {
		orderEntity.setOrderDate(DateUtil.localDateTimeToTimeStamp(LocalDateTime.now())); 
        orderEntity.setOrderCode(generateOrderCode(userCode));
        orderEntity.setOrderStatus("STANDBY");
        orderEntity.setUserCode(userCode);
        return orderEntity;
    }
	

	private OrderResponse setDtoOrderFields(OrderEntity orderEntity) {
		OrderResponse orderDto = new OrderResponse();
		orderDto.setOrderCode(orderEntity.getOrderCode());
		orderDto.setOrderDate(orderEntity.getOrderDate());
		orderDto.setOrderStatus(orderEntity.getOrderStatus());
		orderDto.setUserCode(orderEntity.getUserCode());
		return orderDto;
	}
	
	private void setEntityProductFields(OrderProductEntity orderProductEntity, OrderProductRequest orderProductDto) {
	    orderProductEntity.setProductCode(orderProductDto.getProductCode());
	    orderProductEntity.setOrderQuantity(orderProductDto.getOrderQuantity());
	    orderProductEntity.setOrderPrice(orderProductDto.getOrderPrice());
	}

	private OrderProductResponse convertToOrderProductResponse(OrderProductRequest productRequest,String orderCode) {
	    OrderProductResponse productResponse = new OrderProductResponse();
	   
	    productResponse.setOrderCode(orderCode);
	    productResponse.setProductName(productRequest.getProductName());
	    productResponse.setProductImgUrl(productRequest.getProductImgUrl());
	    productResponse.setProductCode(productRequest.getProductCode());
	    productResponse.setOrderQuantity(productRequest.getOrderQuantity());
	    productResponse.setProductPrice(productRequest.getProductPrice());
	    productResponse.setOrderPrice(productRequest.getOrderPrice());
	    
	    return productResponse;
	}
	
	private OrderEntity convertToEntity(int userCode) {
		OrderEntity orderEntity = new OrderEntity();
		
		return setEntityOrderFields(orderEntity,userCode);
	}

	private OrderProductEntity convertToEntity(OrderProductRequest orderProductDto) {
		OrderProductEntity orderProductEntity = new OrderProductEntity();
		setEntityProductFields(orderProductEntity, orderProductDto);
		return orderProductEntity;
	}
	
	/**
	 * 메소드명   : generateOrderCode
	 * 설명    	: orderDate + userCode 조합으로 orderCode 생성
	 * 
	 * @return String : 생성된 orderCode
	 */
	private String generateOrderCode(int userCode) {
		LocalDateTime orderDate = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMddHHmmss");
		return orderDate.format(formatter) + "-" + userCode;
	}

}
