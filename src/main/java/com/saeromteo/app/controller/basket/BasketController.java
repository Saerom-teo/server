package com.saeromteo.app.controller.basket;

import java.util.List;
import java.util.Map;

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

import com.saeromteo.app.model.basket.BasketEntity;
import com.saeromteo.app.service.basket.BasketService;
import com.saeromteo.app.service.product.ProductService;

@Controller
@RequestMapping("/basket")
public class BasketController {

    @Autowired
    BasketService basketService;
    
    @Autowired
    ProductService productService;

    @GetMapping("")
    public String readAll(Model model) {
        List<BasketEntity> basketList = basketService.basketListUser(1);
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
    public String insertBasket(@RequestBody BasketEntity basket, Model model) { 
        basketService.insertBasket(basket); 
        return "mypage/mypage-basket";
    }

    @PutMapping("/updateBasket")
    @ResponseBody
    public ResponseEntity<String> updateBasket(@RequestBody BasketEntity basket) { 
        basketService.updateBasket(basket); 
        return new ResponseEntity<>("업데이트완료", HttpStatus.OK);
    }
    
    @PostMapping("/delete")
    @ResponseBody
    public ResponseEntity<String> deleteBasketItems(@RequestBody List<Map<String, Object>> items) {
        if (items == null || items.isEmpty()) {
            return new ResponseEntity<>("삭제할 항목이 필요합니다.", HttpStatus.BAD_REQUEST);
        }

        for (Map<String, Object> item : items) {
            try {
            	String productCode = item.get("productCode").toString();
                int userId = ((Number) item.get("userId")).intValue();
            	
                // 실제 삭제 로직 수행 (예: 서비스 호출)
                basketService.deleteBasket(productCode, userId);

                System.out.println("삭제할 항목: productCode = " + productCode + ", userId = " + userId);
            } catch (Exception e) {
                // 예외 발생 시 로그 출력
                e.printStackTrace();
                return new ResponseEntity<>("서버 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }

        return new ResponseEntity<>("선택된 항목이 삭제되었습니다.", HttpStatus.OK);
    }
}
