package com.saeromteo.app.model.order;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

public class OrderDto {

	@Getter
	@Setter
	@ToString
	static public class OrderResponse {
		private String orderCode;
		private LocalDateTime orderDate;
		private String orderStatus;
		private Integer userCode;
	}
	
	@Getter
	@Setter
	@ToString
	static public class OrderRequest {
		private LocalDateTime orderDate;
		private String orderStatus;
		private Integer userCode;

	}

}
