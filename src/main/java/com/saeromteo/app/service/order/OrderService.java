package com.saeromteo.app.service.order;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.saeromteo.app.dao.order.OrderDao;
import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailResponse;
import com.saeromteo.app.model.order.OrderDetailDto;
import com.saeromteo.app.model.order.OrderDto;
import com.saeromteo.app.model.order.OrderDto.OrderRequest;
import com.saeromteo.app.model.order.OrderEntity;
import com.saeromteo.app.model.order.OrderProductDto.OrderProductRequest;
import com.saeromteo.app.model.order.OrderProductEntity;

public class OrderService {

	@Autowired
	private OrderDao orderDao;

	@Transactional
	public String createOrder(OrderRequest orderDto) {
		OrderEntity orderEntity = convertToEntity(orderDto);
		orderDao.createOrder(orderEntity);
		return orderEntity.getOrderCode();
	}
	
	@Transactional
    public void createOrderProducts(List<OrderProductRequest> productRequests) {
        for (OrderProductRequest productRequest : productRequests) {
            OrderProductEntity orderProductEntity = convertToEntity(productRequest);
            orderDao.createOrderProduct(orderProductEntity);
        }
    }
	
	public List<OrderDetailResponse> readAll(){
		return orderDao.readAll();
	}

	public List<OrderDetailResponse> readByUser(int userCode){
		return orderDao.readByUser(userCode);
	}
	
	private OrderEntity convertToEntity(OrderRequest orderDto) {
	    OrderEntity orderEntity = new OrderEntity();
	    setOrderFields(orderEntity, orderDto);
	    return orderEntity;
	}

	private OrderProductEntity convertToEntity(OrderProductRequest orderProductDto) {
	    OrderProductEntity orderProductEntity = new OrderProductEntity();
	    setProductFields(orderProductEntity, orderProductDto);
	    return orderProductEntity;
	}

	private void setOrderFields(OrderEntity orderEntity, OrderRequest orderDto) {
	    orderEntity.setOrderDate(orderDto.getOrderDate());
	    orderEntity.setOrderStatus(orderDto.getOrderStatus());
	}

	private void setProductFields(OrderProductEntity orderProductEntity, OrderProductRequest orderProductDto) {
	    orderProductEntity.setProductCode(orderProductDto.getProductCode());
	    orderProductEntity.setOrderQuantity(orderProductDto.getOrderQuantity());
	    orderProductEntity.setProductPrice(orderProductDto.getProductPrice());
	}

}
