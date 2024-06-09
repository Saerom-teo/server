package com.saeromteo.app.dao.wishlist;

import java.util.List;
import java.util.Map;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import com.saeromteo.app.dto.wishlist.WishlistDTO.WishlistRequest;
import com.saeromteo.app.dto.wishlist.WishlistDTO.WishlistResponse;

@Repository
public class WishlistDAO {
    
    private final SqlSessionTemplate sqlSession;
    private String NAMESPACE = "com.saeromteo.app.wishlist.";

    @Autowired
    public WishlistDAO(@Qualifier("wishlistSqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }

    public List<WishlistResponse> readAll() {
        return sqlSession.selectList(NAMESPACE + "readAll");
    }

    public WishlistResponse readByProductCodeAndUserId(int productCode, int userId) {
        return sqlSession.selectOne(NAMESPACE + "readByProductCodeAndUserId", Map.of("productCode", productCode, "userId", userId));
    }

    public int insertWishlist(WishlistRequest wishlist) {
        return sqlSession.insert(NAMESPACE + "insertWishlist", wishlist);
    }

    public int deleteWishlist(int productCode, int userId) {
        return sqlSession.delete(NAMESPACE + "deleteWishlist", Map.of("productCode", productCode, "userId", userId));
    }
}
