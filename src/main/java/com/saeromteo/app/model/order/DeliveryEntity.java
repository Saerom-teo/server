package com.saeromteo.app.model.order;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DeliveryEntity {
	String deliveryCode;
	String recipient;
	String address;
	String phoneNumber;
	String waybillCode;
	Date shipmentDate;
	String deliveryStatus;
	Date arrivalDate;
	String orderCode;
	String zipCode;
	String deliveryMemo; 
}
