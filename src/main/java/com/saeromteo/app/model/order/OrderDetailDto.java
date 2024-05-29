package com.saeromteo.app.model.order;



import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

public class OrderDetailDto {
	@Getter
	@Setter
	@ToString
	static public class OrderDetailResponse {
		private String orderCode;
		private LocalDateTime orderDate;
		private String orderStatus;
		private Integer userCode;
		private Integer productCode;
		private Integer orderQuantity;
		private Integer productPrice;
	}
	
	@Getter
	@Setter
	@ToString
	static public class OrderDetailRequest {
		private String orderCode;
		private LocalDateTime orderDate;
		private String orderStatus;
		private Integer userCode;
		private Integer orderQuantity;
		private Integer productCode;
		private Integer productPrice;
	}

}
