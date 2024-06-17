package com.saeromteo.app.controller.wishlist;

import com.saeromteo.app.dto.wishlist.WishlistDTO.WishlistResponse;
import com.saeromteo.app.service.wishlist.WishlistService;
import com.saeromteo.app.dto.wishlist.WishlistDTO.WishlistRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/wishlist")
public class WishlistController {

    @Autowired
    WishlistService wishlistService;

    @GetMapping(value="/readAll", produces = "application/json")
    public List<WishlistResponse> readAll() {
        return wishlistService.readAll();
    }

    @GetMapping(value="/readByProductCodeAndUserId/{productCode}/{userId}", produces = "application/json")
    public WishlistResponse readByProductCodeAndUserId(@PathVariable Integer productCode, @PathVariable Integer userId) {
        return wishlistService.readByProductCodeAndUserId(productCode, userId);
    }

    @PostMapping(value = "/insertWishlist", produces =  "text/plain;charset=utf-8", consumes = "application/json")
    public String insertWishlist(@RequestBody WishlistRequest wishlist) {
        int result = wishlistService.insertWishlist(wishlist);
        return result + "개의 위시리스트 항목이 추가되었습니다.";
    }

    @DeleteMapping(value = "/deleteWishlist/{productCode}/{userId}", produces =  "text/plain;charset=utf-8")
    public String deleteWishlist(@PathVariable Integer productCode, @PathVariable Integer userId) {
        int result = wishlistService.deleteWishlist(productCode, userId);
        return result + "개의 위시리스트 항목이 삭제되었습니다.";
    }
    
    @GetMapping(value="/readAllPaged", produces = "application/json")
    public List<WishlistResponse> readAllPaged(@RequestParam int page, @RequestParam int size) {
        return wishlistService.readAllPaged(page, size);
    }
}
