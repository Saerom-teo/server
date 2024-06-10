package com.saeromteo.app.controller.basket;

import com.saeromteo.app.dto.basket.BasketDTO.BasketResponse;
import com.saeromteo.app.service.basket.BasketService;
import com.saeromteo.app.dto.basket.BasketDTO.BasketRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/basket")
public class BasketController {

    @Autowired
    BasketService basketService;

    @GetMapping(value="/readAll", produces = "application/json")
    public List<BasketResponse> readAll() {
        return basketService.readAll();
    }

    @GetMapping(value="/readByProductCodeAndUserId/{productCode}/{userId}", produces = "application/json")
    public BasketResponse readByProductCodeAndUserId(@PathVariable Integer productCode, @PathVariable Integer userId) {
        return basketService.readByProductCodeAndUserId(productCode, userId);
    }

    @PostMapping(value = "/insertBasket", produces =  "text/plain;charset=utf-8", consumes = "application/json")
    public String insertBasket(@RequestBody BasketRequest basket) {
        int result = basketService.insertBasket(basket);
        return result + "개의 장바구니 항목이 추가되었습니다.";
    }

    @PutMapping(value = "/updateBasket", produces =  "text/plain;charset=utf-8", consumes = "application/json")
    public String updateBasket(@RequestBody BasketRequest basket) {
        int result = basketService.updateBasket(basket);
        return result + "개의 장바구니 항목이 업데이트되었습니다.";
    }

    @DeleteMapping(value = "/deleteBasket/{productCode}/{userId}", produces =  "text/plain;charset=utf-8")
    public String deleteBasket(@PathVariable Integer productCode, @PathVariable Integer userId) {
        int result = basketService.deleteBasket(productCode, userId);
        return result + "개의 장바구니 항목이 삭제되었습니다.";
    }
}
