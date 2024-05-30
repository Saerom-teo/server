package com.saeromteo.app.model.order;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

public class DeliveryDto {
	
	@Getter
	@Setter
	@ToString
	static public class DeliveryResponse {
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
	}
	
	@Getter
	@Setter
	@ToString
	static public class DeliveryRequest {
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
	}

}
