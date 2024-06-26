package com.saeromteo.app.dao.product;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import com.saeromteo.app.model.product.DiscountEntity;

@Repository
public class DiscountDAO {
    
    private final SqlSessionTemplate sqlSession;
    private String NAMESPACE = "com.saeromteo.app.product.";

    @Autowired
    public DiscountDAO(@Qualifier("discountSqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }

    public List<DiscountEntity> readAll() {
        return sqlSession.selectList(NAMESPACE + "readAll");
    }

    public DiscountEntity readById(int discountCode) {
        return sqlSession.selectOne(NAMESPACE + "readById", discountCode);
    }

    public int insertDiscount(DiscountEntity discount) {
        return sqlSession.insert(NAMESPACE + "insertDiscount", discount);
    }

    public int updateDiscount(DiscountEntity discount) {
        return sqlSession.update(NAMESPACE + "updateDiscount", discount);
    }

    public int deleteDiscount(int discountCode) {
        return sqlSession.delete(NAMESPACE + "deleteDiscount", discountCode);
    }
}
