package com.saeromteo.app.dao.basket;

import java.util.List;
import java.util.Map;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import com.saeromteo.app.dto.basket.BasketDTO.BasketRequest;
import com.saeromteo.app.dto.basket.BasketDTO.BasketResponse;

@Repository
public class BasketDAO {
    
    private final SqlSessionTemplate sqlSession;
    private String NAMESPACE = "com.saeromteo.app.basket.";

    @Autowired
    public BasketDAO(@Qualifier("basketSqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }

    public List<BasketResponse> readAll() {
        return sqlSession.selectList(NAMESPACE + "readAll");
    }

    public BasketResponse readByProductCodeAndUserId(int productCode, int userId) {
        return sqlSession.selectOne(NAMESPACE + "readByProductCodeAndUserId", Map.of("productCode", productCode, "userId", userId));
    }

    public int insertBasket(BasketRequest basket) {
        return sqlSession.insert(NAMESPACE + "insertBasket", basket);
    }

    public int updateBasket(BasketRequest basket) {
        return sqlSession.update(NAMESPACE + "updateBasket", basket);
    }

    public int deleteBasket(int productCode, int userId) {
        return sqlSession.delete(NAMESPACE + "deleteBasket", Map.of("productCode", productCode, "userId", userId));
    }
}
