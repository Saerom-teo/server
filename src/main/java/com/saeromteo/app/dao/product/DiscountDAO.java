package com.saeromteo.app.dao.product;

import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.dto.product.DiscountDTO.DiscountRequest;
import com.saeromteo.app.dto.product.DiscountDTO.DiscountResponse;

@Repository
public class DiscountDAO {
    
    private final SqlSessionTemplate sqlSession;
    private String NAMESPACE = "com.saeromteo.app.product.";

    @Autowired
    public DiscountDAO(@Qualifier("discountSqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }

    public List<DiscountResponse> readAll() {
        return sqlSession.selectList(NAMESPACE + "readAll");
    }

    public DiscountResponse readById(int discountCode) {
        return sqlSession.selectOne(NAMESPACE + "readById", discountCode);
    }

    public int insertDiscount(DiscountRequest discount) {
        return sqlSession.insert(NAMESPACE + "insertDiscount", discount);
    }

    public int updateDiscount(DiscountRequest discount) {
        return sqlSession.update(NAMESPACE + "updateDiscount", discount);
    }

    public int deleteDiscount(int discountCode) {
        return sqlSession.delete(NAMESPACE + "deleteDiscount", discountCode);
    }
}
