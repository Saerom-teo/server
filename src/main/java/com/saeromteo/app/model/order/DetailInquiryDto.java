package com.saeromteo.app.model.order;

import java.sql.Timestamp;
import java.util.List;

import com.saeromteo.app.model.order.OrderProductDto.OrderProductResponse;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DetailInquiryDto {
	private String orderCode;
	private Timestamp orderDate;
	private String orderStatus;
	
	private List<OrderProductResponse> products;
	
	private String recipient;
	private String address;
	private String phoneNumber;
	private String zipCode;
	private String waybillCode;
	private String deliveryMemo; 
	private Integer totalOrderPrice;
    private Integer shippingPrice;
	
}
