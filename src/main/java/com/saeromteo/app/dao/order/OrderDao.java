package com.saeromteo.app.dao.order;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.model.order.OrderDetailDto;
import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailResponse;
import com.saeromteo.app.model.order.OrderDto.OrderRequest;
import com.saeromteo.app.model.order.OrderEntity;
import com.saeromteo.app.model.order.OrderProductEntity;

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

}
