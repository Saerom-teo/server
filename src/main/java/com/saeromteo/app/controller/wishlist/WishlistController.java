package com.saeromteo.app.controller.wishlist;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.saeromteo.app.model.wishlist.WishListEntity;
import com.saeromteo.app.service.wishlist.WishlistService;

@Controller
// @RestController
@RequestMapping("/wishlist")
public class WishlistController {

    @Autowired
    WishlistService wishlistService;
    
    @GetMapping(value = "/test")
	 public String test() {
		return "wishlist/wishlist";
	}

    @GetMapping(value="/readAll", produces = "application/json")
    public List<WishListEntity> readAll() {
        return wishlistService.readAll();
    }

    @GetMapping(value="/readByProductCodeAndUserId/{productCode}/{userId}", produces = "application/json")
    public WishListEntity readByProductCodeAndUserId(@PathVariable Integer productCode, @PathVariable Integer userId) {
        return wishlistService.readByProductCodeAndUserId(productCode, userId);
    }

    @PostMapping(value = "/insertWishlist", produces =  "text/plain;charset=utf-8", consumes = "application/json")
    public String insertWishlist(@RequestBody WishListEntity wishlist) {
        int result = wishlistService.insertWishlist(wishlist);
        return result + "개의 위시리스트 항목이 추가되었습니다.";
    }

    @DeleteMapping(value = "/deleteWishlist/{productCode}/{userId}", produces =  "text/plain;charset=utf-8")
    public String deleteWishlist(@PathVariable Integer productCode, @PathVariable Integer userId) {
        int result = wishlistService.deleteWishlist(productCode, userId);
        return result + "개의 위시리스트 항목이 삭제되었습니다.";
    }
    
    @GetMapping(value="/readAllPaged", produces = "application/json")
    public List<WishListEntity> readAllPaged(@RequestParam int page, @RequestParam int size) {
        return wishlistService.readAllPaged(page, size);
    }
}
