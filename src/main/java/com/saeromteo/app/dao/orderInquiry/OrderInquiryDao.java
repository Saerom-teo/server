package com.saeromteo.app.dao.orderInquiry;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailResponse;


@Repository
public class OrderInquiryDao {
	private final SqlSessionTemplate sqlSession;
    private String namespace = "com.saeromteo.orderInquiry.";
    
    @Autowired
    public OrderInquiryDao(@Qualifier("orderInquirySqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }
    
    public List<OrderDetailResponse> readAll(int userCode){
		return sqlSession.selectList(namespace + "readAll", userCode);
	}
}
