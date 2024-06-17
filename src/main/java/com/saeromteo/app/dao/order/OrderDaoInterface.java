package com.saeromteo.app.dao.order;

import java.util.List;

import com.saeromteo.app.model.order.OrderDetailDto;
import com.saeromteo.app.model.order.OrderDto.OrderRequest;
import com.saeromteo.app.model.order.OrderEntity;
import com.saeromteo.app.model.order.OrderProductEntity;

public interface OrderDaoInterface {
	
	public int createOrder(OrderEntity orderEntity);
	
	public int createOrderProduct(OrderProductEntity orderProductEntity);
	
	public List<OrderDetailDto>readAll();
	
	public List<OrderDetailDto>readByUser(int userCode);
	
	public int changeOrderStatus(String orderCode,String orderStatus);
	
}
