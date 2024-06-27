package com.saeromteo.app.dao.orderInquiry;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    
    public List<OrderDetailResponse> readByPeriod(int userCode, String startDate, String endDate) {
    	Map<String, Object> periodInfo = new HashMap<>();
        periodInfo.put("userCode", userCode);
        periodInfo.put("startDate", startDate);
        periodInfo.put("endDate", endDate);
        System.err.println(startDate + " " + endDate);
        System.out.println(sqlSession.selectList(namespace + "readByPeriod", periodInfo));
    	return sqlSession.selectList(namespace + "readByPeriod", periodInfo);
    }
}
