package com.saeromteo.app.model.order;

import java.time.LocalDateTime;
import java.util.List;
import com.saeromteo.app.model.order.OrderProductDto.OrderProductRequest;
import com.saeromteo.app.model.order.OrderProductDto.OrderProductResponse;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


public class OrderDetailDto {
	
	@Getter
	@Setter
	@ToString
	static public class OrderDetailResponse {
		private OrderDto.OrderResponse order;
	    private List<OrderProductResponse> products;
	    private Integer totalOrderPrice;
	    private Integer shippingPrice;
	}

	@Getter
	@Setter
	@ToString
	static public class OrderDetailRequest{
    private List<OrderProductRequest> products;
    private Integer totalOrderPrice;
    private Integer shippingPrice;
	}
	
	

}
