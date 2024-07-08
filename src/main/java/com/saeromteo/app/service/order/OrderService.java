package com.saeromteo.app.service.order;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import com.saeromteo.app.jwt.JWTUtil;
import com.saeromteo.app.util.DateUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import com.saeromteo.app.dao.order.OrderDao;
import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailRequest;
import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailResponse;
import com.saeromteo.app.model.order.DeliveryEntity;
import com.saeromteo.app.model.order.OrderDetailDto;
import com.saeromteo.app.model.order.OrderDto;
import com.saeromteo.app.model.order.OrderDto.OrderRequest;
import com.saeromteo.app.model.order.OrderDto.OrderResponse;
import com.saeromteo.app.model.order.OrderEntity;
import com.saeromteo.app.model.order.OrderProductDto.OrderProductRequest;
import com.saeromteo.app.model.order.OrderProductDto.OrderProductResponse;
import com.saeromteo.app.model.order.OrderProductEntity;
import com.saeromteo.app.model.order.RecipientInfoDto;
import com.saeromteo.app.model.point.PointEntity;
import com.saeromteo.app.service.point.PointService;

@Service
public class OrderService {

	@Autowired
	private OrderDao orderDao;

	@Autowired
	private PointService pointService;

	/**
	 * 메소드명 : createOrder 설명 : orderDto를 사용하여 orderEntity 생성
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
	 * 메소드명 : createOrderProducts 설명 : productDtos,orderCode를 사용하여
	 * orderProductEntity 생성
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
	 * 메소드명 : updateOrderStatus 설명 : 주문 상태 현황 업데이트
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
	 * 메소드명 : setOrderDetailResponse 설명 : orderDto, orderSuccessDto를 사용하여
	 * OrderDetailResponse 생성
	 * 
	 * @return OrderDetailResponse : 페이지 전환 시 서버로 전달해주는 값
	 */
	public OrderDetailResponse setOrderDetailResponse(OrderResponse orderDto, OrderDetailRequest orderSuccessDto) {
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
	 * 메소드명 : stockCheck
	 * 
	 * 
	 * @return boolean 주문 가능하면 true, 불가능하면 false
	 */
	public boolean stockCheck(List<OrderProductRequest> orderProduct) {
		for (OrderProductRequest product : orderProduct) {
			String productCode = product.getProductCode();
			int productQuantity = orderDao.stockCheck(productCode);
			int orderQuantity = product.getOrderQuantity();
			if (productQuantity < orderQuantity) {
				return false;
			}
		}
		return true;
	}

	/**
	 * 메소드명 : getTotalPoints
	 * 
	 * 포인트가 없을 경우 0으로 초기화(orderDao에서)
	 * 
	 * @return 포인트 값
	 */
	public int getTotalPoints(int userCode) {
		return orderDao.getTotalPoints(userCode);
	}

	/**
	 * 메소드명 : getRecipientInfo
	 * 			배송지 정보를 받고 주소는 '/'를 기준으로 주소와 상세주소 분리 후 저장 
	 * 
	 * @return 배송지 정보
	 */
	public RecipientInfoDto getRecipientInfo(int userCode) {
		RecipientInfoDto recipientInfo = orderDao.getRecipientInfo(userCode);
		
		String fullAddress = recipientInfo.getAddress();
	    if (fullAddress != null) {
	        String[] addressParts = fullAddress.split("/", 2);
	        if (addressParts.length == 2) {
	            recipientInfo.setAddress(addressParts[0]);
	            recipientInfo.setDetailAddress(addressParts[1]);
	        } else {
	            recipientInfo.setAddress(fullAddress);
	            recipientInfo.setDetailAddress("");
	        }
	    }
		return recipientInfo;

	}

	/**
	 * 메소드명 : updateStock 설명 : 받아온 데이터를 통해서 재고 업데이트
	 * 
	 * @return void
	 */
	public void updateStock(List<OrderProductResponse> orderProduct) {
		for (OrderProductResponse product : orderProduct) {
			orderDao.updateStock(product);
		}

	}

	/**
	 * 메소드명 : registerPoint 설명 : 포인트 내역에 등록
	 * 
	 * @return void
	 */
	public void registerPoint(int userCode, int usedPoints, String orderCode) {
		PointEntity pointEntity = new PointEntity();
		pointEntity.setUserId(userCode); // 사용자 코드 설정
		pointEntity.setAmount(usedPoints);
		pointEntity.setType("spent");
		pointEntity.setSpendingSource("purchase");
		pointEntity.setOrderCode(orderCode);
		LocalDate now = LocalDate.now();
		java.sql.Date sqlDate = java.sql.Date.valueOf(now);
		pointService.insert(pointEntity);

	}
	
	
	public int setRecipient(String recipient,String phoneNumber, String address,String deliveryMemo,String orderCode,int userCode) {
		
	
		// 정규 표현식을 사용하여 주소와 우편번호 분리
        String addressPattern = "^(.*)\\s\\((\\d{5})\\)$";
        Pattern pattern = Pattern.compile(addressPattern);
        Matcher matcher = pattern.matcher(address);
        
        String parsedAddress = "";
        String zipCode = "";
        
        if (matcher.find()) {
            parsedAddress = matcher.group(1);
            zipCode = matcher.group(2);
        } else {
            parsedAddress = address;
        }
        DeliveryEntity deliveryEntity = new DeliveryEntity();
        deliveryEntity.setDeliveryCode(generateOrderCode(userCode));
        deliveryEntity.setRecipient(recipient);
        deliveryEntity.setAddress(parsedAddress);
        deliveryEntity.setPhoneNumber(phoneNumber);
        deliveryEntity.setOrderCode(orderCode);
        deliveryEntity.setZipCode(zipCode);
        deliveryEntity.setDeliveryMemo(deliveryMemo);
        System.err.println(deliveryEntity.toString());
        return orderDao.setRecipient(deliveryEntity);
	}
	
	public int deductPoints(int userCode,int usedPoint) {
		return orderDao.deductPoints(userCode,usedPoint);
	}


	public List<OrderDetailResponse> readAll() {
		return orderDao.readAll();
	}

	public List<OrderDetailResponse> readByUser(int userCode) {
		return orderDao.readByUser(userCode);
	}

	/**
	 * 메소드명 : setEntityOrderFields 설명 : EntityField 를 설정하고 OrderCode는 함수를 통해서 삽입
	 * 
	 * @return orderEntity
	 */
	private OrderEntity setEntityOrderFields(OrderEntity orderEntity, int userCode) {
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

	private OrderProductResponse convertToOrderProductResponse(OrderProductRequest productRequest, String orderCode) {
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

		return setEntityOrderFields(orderEntity, userCode);
	}

	private OrderProductEntity convertToEntity(OrderProductRequest orderProductDto) {
		OrderProductEntity orderProductEntity = new OrderProductEntity();
		setEntityProductFields(orderProductEntity, orderProductDto);
		return orderProductEntity;
	}

	/**
	 * 메소드명 : generateOrderCode 설명 : orderDate + userCode 조합으로 orderCode 생성
	 * 
	 * @return String : 생성된 orderCode
	 */
	private String generateOrderCode(int userCode) {
		LocalDateTime orderDate = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMddHHmmss");
		return orderDate.format(formatter) + "-" + userCode;
	}

}
