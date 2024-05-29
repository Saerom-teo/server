package com.saeromteo.app.model.order;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class OrderProductEntity {
	
	private Integer productCode;
	private String orderCode;
	private Integer orderQuantity;
	private Integer productPrice;
	
	
}
