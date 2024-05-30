package com.saeromteo.app.model.order;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderProductDto {
	
	@Getter
	@Setter
	@ToString
	static public class OrderProductResponse {
		private Integer productCode;
		private Integer orderQuantity;
		private Integer productPrice;
		private String orderCode;
	}
	
	@Getter
	@Setter
	@ToString
	static public class OrderProductRequest {
		private Integer productCode;
		private Integer orderQuantity;
		private Integer productPrice;
		private String orderCode;
	}
	
	
}
