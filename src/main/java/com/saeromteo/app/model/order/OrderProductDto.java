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
		private String productCode;
		private String productName;
		private Integer orderQuantity;
		private Integer productPrice;
		private String orderCode;
		private Integer orderPrice; 
		private String productImgUrl;
	}
	
	@Getter
	@Setter
	@ToString
	static public class OrderProductRequest {
		
		private String productCode;
		private String productName;
		private Integer orderQuantity;
		private Integer productPrice;
		private String orderCode;
		private Integer orderPrice; 
		private String productImgUrl;
	}
	
	
}
