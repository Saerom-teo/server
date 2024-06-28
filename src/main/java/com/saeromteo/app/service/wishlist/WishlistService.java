package com.saeromteo.app.service.wishlist;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.wishlist.WishlistDAO;
import com.saeromteo.app.model.wishlist.WishListEntity;

@Service
public class WishlistService {

    @Autowired
    WishlistDAO wishlistDAO;

    public List<WishListEntity> readAll() {
        return wishlistDAO.readAll();
    }
    public List<WishListEntity> wishListUser(Integer userId) {
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
}
