package com.saeromteo.app.controller.wishlist;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.saeromteo.app.model.wishlist.WishListEntity;
import com.saeromteo.app.service.product.ProductService;
import com.saeromteo.app.service.wishlist.WishlistService;

@Controller
// @RestController
@RequestMapping("/wishlist")
public class WishlistController {

    @Autowired
    WishlistService wishlistService;
    
    @Autowired
    ProductService productService;
    
    @GetMapping("")
    public String readAll(Model model) {
    	List<WishListEntity> wishList = wishlistService.wishListUser(1);
    	model.addAttribute("wishList", wishList);
    	return "mypage/mypage-wishlist";
    }
    
    @GetMapping("/user/{userId}")
    public String readByProductCodeAndUserId(@PathVariable Integer userId, Model model) {
    	 List<WishListEntity> userBasket = wishlistService.readByProductCodeAndUserId(userId); 
         model.addAttribute("userBasket", userBasket);
         return "mypage/mypage-wishlist";
    }

    @PostMapping(value = "/insertWishlist")
    public String insertWishlist(@RequestBody WishListEntity wishlist) {
        wishlistService.insertWishlist(wishlist);
        return "mypage/mypage-wishlist";
    }

    @DeleteMapping(value = "/delete/{productCode}/{userId}")
    @ResponseBody
    public ResponseEntity<String> deleteWishlist(@PathVariable Integer productCode, @PathVariable Integer userId) {
        int result = wishlistService.deleteWishlist(productCode, userId);
        return ResponseEntity.ok(result + "개의 위시리스트 항목이 삭제되었습니다.");
    }
    
    @GetMapping(value="/readAllPaged", produces = "application/json")
    public List<WishListEntity> readAllPaged(@RequestParam int page, @RequestParam int size) {
        return wishlistService.readAllPaged(page, size);
    }
}
