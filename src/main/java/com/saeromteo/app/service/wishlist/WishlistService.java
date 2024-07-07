package com.saeromteo.app.service.wishlist;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.wishlist.WishlistDAO;
import com.saeromteo.app.model.wishlist.WishListEntity;

@Service
public class WishlistService {

    @Autowired
    WishlistDAO wishlistDAO;

    public List<WishListEntity> readAll(Integer userId, int page, int pageSize) {
    	int offset = (page - 1) * pageSize;
    	Map<String, Object> params = new HashMap<>();
    	params.put("userId", userId);
        params.put("limit", pageSize);
        params.put("offset", offset);
        return wishlistDAO.readAll(params);
    }
    public int wishListUser(Integer userId) {
		return wishlistDAO.wishListUser(userId); 
	}

    public List<WishListEntity> readByProductCodeAndUserId(int userId) {
        return wishlistDAO.readByProductCodeAndUserId(userId);
    }

    public int insertWishlist(WishListEntity wishlist) {
       return wishlistDAO.insertWishlist(wishlist);
    }

    public int deleteWishlist(int productCode, int userId) {
       return wishlistDAO.deleteWishlist(productCode, userId);
    }
    
    public List<WishListEntity> readAllPaged(int page, int size) {
        int offset = (page - 1) * size; 
        return wishlistDAO.readAllPaged(offset, size);
    }
    public boolean isProductInWishlist(String productCode, int userId) {
        return wishlistDAO.isProductInWishlist(productCode, userId);
    }
}
