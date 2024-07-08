package com.saeromteo.app.dao.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.model.order.DeliveryEntity;
import com.saeromteo.app.model.order.OrderDetailDto;
import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailResponse;
import com.saeromteo.app.model.order.OrderDto.OrderRequest;
import com.saeromteo.app.model.order.OrderEntity;
import com.saeromteo.app.model.order.OrderProductDto.OrderProductRequest;
import com.saeromteo.app.model.order.OrderProductDto.OrderProductResponse;
import com.saeromteo.app.model.order.OrderProductEntity;
import com.saeromteo.app.model.order.RecipientInfoDto;

@Repository
public class OrderDao {

	private final SqlSessionTemplate sqlSession;
    private String namespace = "com.saeromteo.order.";

    @Autowired
    public OrderDao(@Qualifier("orderSqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }
	
	public int createOrder(OrderEntity orderEntity) {
		int result =  sqlSession.insert(namespace + "createOrder", orderEntity);
		return result;
	}

	public int createOrderProduct(OrderProductEntity orderProductEntity) {
		int result = sqlSession.insert(namespace + "createOrderProduct", orderProductEntity);
		return result;
	}
	
	public List<OrderDetailResponse> readAll(){
		return sqlSession.selectList(namespace + "readAll");
	}

	public List<OrderDetailResponse> readByUser(int userCode){
		return sqlSession.selectList(namespace + "readByUser" , userCode);
	}
	
	public int updateOrderStatus (Map<String, String> orderStatusInfo) {
		int result = sqlSession.update(namespace + "updateOrderStatus", orderStatusInfo);
		return result;
	}
	
	public int stockCheck (String productCode) {
		int result = sqlSession.selectOne(namespace + "stockCheck", productCode);
		return result;
	}
	
	public RecipientInfoDto getRecipientInfo(int userCode) {
		return sqlSession.selectOne(namespace + "getRecipientInfo", userCode);
	}
	
	
	public int getTotalPoints(int userCode) {
		
		if(sqlSession.selectOne(namespace + "getTotalPoints", userCode)==null) {
			return 0;
		}
		return sqlSession.selectOne(namespace + "getTotalPoints", userCode);
		
	}
	
	public int updateStock(OrderProductResponse product) {
		return sqlSession.update(namespace + "updateStock", product);
	}

	public int deductPoints(int userCode, int usedPoints) {
		Map<String, Object> deductPoints = new HashMap<>();
		System.err.println("usedPoints"+usedPoints);
		deductPoints.put("userCode", userCode);
		deductPoints.put("usedPoints", usedPoints);
	    return sqlSession.update(namespace + "deductPoints", deductPoints);
	}
	
	public int setRecipient(DeliveryEntity deliveryEntity) {
		System.err.println(deliveryEntity.toString());
		int result =  sqlSession.insert(namespace + "setRecipient", deliveryEntity);
		return result;
	}
	
	

}
