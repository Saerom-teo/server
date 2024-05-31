package com.saeromteo.app.model.order;

import java.util.List;
import com.saeromteo.app.model.order.OrderProductDto.OrderProductRequest;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderSuccessDto {

	private OrderDto.OrderRequest order;
    private List<OrderProductRequest> products;

}
