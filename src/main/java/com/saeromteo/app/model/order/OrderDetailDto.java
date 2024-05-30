package com.saeromteo.app.model.order;

import java.time.LocalDateTime;
import java.util.List;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import java.sql.Timestamp;

public class OrderDetailDto {
	
	@Getter
	@Setter
	@ToString
	static public class OrderDetailResponse {
		private String orderCode;
		private Timestamp orderDate;
		private String orderStatus;
		private Integer userCode;
		private List<OrderProductDto.OrderProductResponse> products; 
	}
	
	@Getter
	@Setter
	@ToString
	static public class OrderDetailRequest {
		private String orderCode;
		private LocalDateTime orderDate;
		private String orderStatus;
		private Integer userCode;
		private List<OrderProductDto.OrderProductResponse> products; 
	}

}
