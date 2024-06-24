package com.saeromteo.app.controller.basket;

import com.saeromteo.app.dto.basket.BasketDTO.BasketResponse;
import com.saeromteo.app.service.basket.BasketService;
import com.saeromteo.app.dto.basket.BasketDTO.BasketRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import javax.servlet.http.HttpSession;


@Controller
@RequestMapping("/basket")
public class BasketController {

	@Autowired
	BasketService basketService;
	
	@GetMapping(value = "/basket", produces = "application/json")
	public String getUserBasket(Model model) {
		Integer userId = 1; // 임시로 userId를 1로 설정
	    List<BasketResponse> basketList = basketService.readByUserId(userId);
	    model.addAttribute("basketList", basketList);
	    return "basket/basket";
	}
	

	@GetMapping(value = "/readAll", produces = "application/json")
	public List<BasketResponse> readAll() {
		return basketService.readAll();
	}

	@GetMapping(value = "/readByProductCodeAndUserId/{productCode}/{userId}", produces = "application/json")
	public BasketResponse readByProductCodeAndUserId(@PathVariable Integer productCode, @PathVariable Integer userId) {
		return basketService.readByProductCodeAndUserId(productCode, userId);
	}
	

    @GetMapping(value = "/readByUserId/{userId}", produces = "application/json")
    @ResponseBody
    public List<BasketResponse> readByUserId(@PathVariable Integer userId) {
        return basketService.readByUserId(userId);
    }

	/* 장바구니 항목을 추가한 후 장바구니 페이지로 리다이렉트 */
    @PostMapping(value = "/insertBasket", produces = "text/plain;charset=utf-8", consumes = "application/json")
    @ResponseBody
    public String insertBasket(@RequestBody BasketRequest basket, HttpSession session) {
        basketService.insertBasket(basket);
        return "redirect:/basket";
    }

	@PutMapping(value = "/updateBasket", produces = "text/plain;charset=utf-8", consumes = "application/json")
	@ResponseBody
	public String updateBasket(@RequestBody BasketRequest basket) {
		int result = basketService.updateBasket(basket);
		return result + "개의 장바구니 항목이 업데이트되었습니다.";
	}

	@DeleteMapping(value = "/deleteBasket/{productCode}/{userId}", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String deleteBasket(@PathVariable Integer productCode, @PathVariable Integer userId) {
		int result = basketService.deleteBasket(productCode, userId);
		return result + "개의 장바구니 항목이 삭제되었습니다.";
	}
}
