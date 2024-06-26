package com.saeromteo.app.dao.order;

import java.util.List;

import com.saeromteo.app.model.order.OrderDetailDto;
import com.saeromteo.app.model.order.OrderDto.OrderRequest;
import com.saeromteo.app.model.order.OrderProductDto.OrderProductResponse;
import com.saeromteo.app.model.order.OrderEntity;
import com.saeromteo.app.model.order.OrderProductEntity;
import com.saeromteo.app.model.order.RecipientInfoDto;

public interface OrderDaoInterface {
	
	public int createOrder(OrderEntity orderEntity);
	
	public int createOrderProduct(OrderProductEntity orderProductEntity);
	
	public List<OrderDetailDto>readAll();
	
	public List<OrderDetailDto>readByUser(int userCode);
	
	public int updateOrderStatus(String orderCode,String orderStatus);
	
	public int stockCheck (String productCode);
	
	public RecipientInfoDto getRecipientInfo(int userCode);
	
	public int getTotalPoints(int userCode);
	
	public int updateStock(OrderProductResponse product);
	
	public int deductPoints(int userCode, int usedPoints) ;
	
}
