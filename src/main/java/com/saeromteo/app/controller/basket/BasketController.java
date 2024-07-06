package com.saeromteo.app.controller.basket;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.saeromteo.app.jwt.JWTUtil;
import com.saeromteo.app.model.basket.BasketEntity;
import com.saeromteo.app.service.basket.BasketService;
import com.saeromteo.app.service.product.ProductService;
import com.saeromteo.app.service.user.UserService;

@Controller
@RequestMapping("/mypage/basket")
public class BasketController {

    @Autowired
    BasketService basketService;
    
    @Autowired
    ProductService productService;
    
    @Autowired
	UserService userService;
    
    @Autowired
	JWTUtil jwtUtil;
    
    @GetMapping("/getUserId")
    @ResponseBody
    public ResponseEntity<Integer> getUserId(HttpServletRequest request) {
        String token = jwtUtil.getJwtFromCookies(request);
        int userId = jwtUtil.getUserIdFromToken(token);
        return ResponseEntity.ok(userId);
    }

    @GetMapping("")
    public String readAll(Model model, HttpServletRequest request) {
    	String token = jwtUtil.getJwtFromCookies(request);
		int userId = jwtUtil.getUserIdFromToken(token);
		
        List<BasketEntity> basketList = basketService.basketListUser(userId);
        model.addAttribute("basketList", basketList);
        return "mypage/mypage-basket";
    }

    @GetMapping("/user/{userId}")
    public String getUserBasket(@PathVariable Integer userId, Model model) {
        List<BasketEntity> userBasket = basketService.readByUserId(userId); 
        model.addAttribute("userBasket", userBasket);
        return "mypage/mypage-basket";
    }

    @PostMapping("/insertBasket")
    @ResponseBody
    public String insertBasket(@RequestBody BasketEntity basket, HttpServletRequest request) { 
        String token = jwtUtil.getJwtFromCookies(request);
        int userId = jwtUtil.getUserIdFromToken(token);
        basket.setUserId(userId);
        
        basketService.insertBasket(basket); 
        return "mypage/mypage-basket";
    }

    @PostMapping("/updateBasket")
    @ResponseBody
    public ResponseEntity<String> updateBasket(@RequestBody BasketEntity basket, HttpServletRequest request) { 
        String token = jwtUtil.getJwtFromCookies(request);
        int userId = jwtUtil.getUserIdFromToken(token);
        basket.setUserId(userId);
        
        basketService.updateBasket(basket); 
        return new ResponseEntity<>("업데이트완료", HttpStatus.OK);
    }
    
    @PostMapping("/delete")
    @ResponseBody
    public ResponseEntity<String> deleteBasketItems(@RequestBody List<Map<String, Object>> items, HttpServletRequest request) {
        if (items == null || items.isEmpty()) {
            return new ResponseEntity<>("삭제할 항목이 필요합니다.", HttpStatus.BAD_REQUEST);
        }

        String token = jwtUtil.getJwtFromCookies(request);
        int userId = jwtUtil.getUserIdFromToken(token);

        for (Map<String, Object> item : items) {
            try {
                String productCode = item.get("productCode").toString();
                
                // 실제 삭제 로직 수행 (예: 서비스 호출)
                basketService.deleteBasket(productCode, userId);

            } catch (Exception e) {
                // 예외 발생 시 로그 출력
                e.printStackTrace();
                return new ResponseEntity<>("서버 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }

        return new ResponseEntity<>("선택된 항목이 삭제되었습니다.", HttpStatus.OK);
    }
}
