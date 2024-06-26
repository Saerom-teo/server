package com.saeromteo.app.dao.basket;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.model.basket.BasketEntity;

@Repository
public class BasketDAO {
    
    private final SqlSessionTemplate sqlSession;
    private String NAMESPACE = "com.saeromteo.app.basket.";

    @Autowired
    public BasketDAO(@Qualifier("basketSqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }

    public List<BasketEntity> readAll() {
        return sqlSession.selectList(NAMESPACE + "readAll");
    }
    public List<BasketEntity> basketListUser(int userId) {
        return sqlSession.selectList(NAMESPACE + "basketListUser", userId);
    }
    
    public List<BasketEntity> readByUserId(int userId) { 
        return sqlSession.selectList(NAMESPACE + "readByProductCodeAndUserId", userId);
    }

    public int insertBasket(BasketEntity basket) { 
        return sqlSession.insert(NAMESPACE + "insertBasket", basket);
    }

    public int updateBasket(BasketEntity basket) { 
        return sqlSession.update(NAMESPACE + "updateBasket", basket);
    }

    public int deleteBasket(String productCode, int userId) { 
        return sqlSession.delete(NAMESPACE + "deleteBasket", Map.of("productCode", productCode, "userId", userId));
    }
}
