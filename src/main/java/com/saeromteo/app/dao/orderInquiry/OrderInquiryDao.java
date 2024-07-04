package com.saeromteo.app.dao.orderInquiry;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.model.order.OrderDetailDto.OrderDetailResponse;
import com.saeromteo.app.model.order.DetailInquiryDto;


@Repository
public class OrderInquiryDao {
	private final SqlSessionTemplate sqlSession;
    private String namespace = "com.saeromteo.orderInquiry.";
    
    @Autowired
    public OrderInquiryDao(@Qualifier("orderInquirySqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }
    
    public List<OrderDetailResponse> readAll(int userCode){
    	System.out.println(sqlSession.selectList(namespace + "readAll", userCode));
    	return sqlSession.selectList(namespace + "readAll", userCode);
	}
    
    public List<DetailInquiryDto> readDetailInquiry(String orderCode){
    	return sqlSession.selectList(namespace + "readDetailInquiry", orderCode);
    }
    
    public List<OrderDetailResponse> readByPeriod(int userCode, String startDate, String endDate) {
    	Map<String, Object> periodInfo = new HashMap<>();
        periodInfo.put("userCode", userCode);
        periodInfo.put("startDate", startDate);
        periodInfo.put("endDate", endDate);
    	return sqlSession.selectList(namespace + "readByPeriod", periodInfo);
    }
    
    public List<OrderDetailResponse> readByCustomPeriod(int userCode, String startDate, String endDate) {
        Map<String, Object> periodInfo = new HashMap<>();
        periodInfo.put("userCode", userCode);
        periodInfo.put("startDate", startDate);
        periodInfo.put("endDate", endDate);
        return sqlSession.selectList(namespace + "readByCustomPeriod", periodInfo);
    }
}
