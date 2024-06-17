package com.saeromteo.app.service.wishlist;

import com.saeromteo.app.dto.wishlist.WishlistDTO.WishlistResponse;
import com.saeromteo.app.dto.wishlist.WishlistDTO.WishlistRequest;
import com.saeromteo.app.dao.wishlist.WishlistDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WishlistService {

    @Autowired
    WishlistDAO wishlistDAO;

    public List<WishlistResponse> readAll() {
        return wishlistDAO.readAll();
    }

    public WishlistResponse readByProductCodeAndUserId(int productCode, int userId) {
        return wishlistDAO.readByProductCodeAndUserId(productCode, userId);
    }

    public int insertWishlist(WishlistRequest wishlist) {
       return wishlistDAO.insertWishlist(wishlist);
    }

    public int deleteWishlist(int productCode, int userId) {
       return wishlistDAO.deleteWishlist(productCode, userId);
    }
    
    public List<WishlistResponse> readAllPaged(int page, int size) {
        int offset = (page - 1) * size; 
        return wishlistDAO.readAllPaged(offset, size);
    }
}
