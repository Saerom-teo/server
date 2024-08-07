package com.saeromteo.app.dao.wishlist;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.model.wishlist.WishListEntity;

@Repository
public class WishlistDAO {
    
    private final SqlSessionTemplate sqlSession;
    private String NAMESPACE = "com.saeromteo.app.wishlist.";

    @Autowired
    public WishlistDAO(@Qualifier("wishlistSqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }

    public List<WishListEntity> readAll(Map<String, Object> params) {
        return sqlSession.selectList(NAMESPACE + "readAll", params);
    }
    
    public int wishListUser(int userId) {
        return sqlSession.selectOne(NAMESPACE + "wishListUser", userId);
    }

    public List<WishListEntity> readByProductCodeAndUserId(int userId) {
    	return sqlSession.selectList(NAMESPACE + "readByProductCodeAndUserId", userId);
    }

    public int insertWishlist(WishListEntity wishlist) {
        return sqlSession.insert(NAMESPACE + "insertWishlist", wishlist);
    }

    public int deleteWishlist(int productCode, int userId) {
        return sqlSession.delete(NAMESPACE + "deleteWishlist", Map.of("productCode", productCode, "userId", userId));
    }
    
    public List<WishListEntity> readAllPaged(int offset, int size) {
        Map<String, Integer> params = new HashMap<>();
        params.put("offset", offset); 
        params.put("size", size);
        return sqlSession.selectList(NAMESPACE + "readAllPaged", params);
    }

    public boolean isProductInWishlist(String productCode, int userId) {
        return sqlSession.selectOne(NAMESPACE + "isProductInWishlist", Map.of("productCode", productCode, "userId", userId));
    }

}
