package com.saeromteo.app.controller.basket;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
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
        return "basket/basket";
    }

    @GetMapping("/user/{userId}")
    public String getUserBasket(@PathVariable Integer userId, Model model) {
        List<BasketEntity> userBasket = basketService.readByUserId(userId); 
        model.addAttribute("userBasket", userBasket);
        return "basket/basket";
    }

    @PostMapping("/insertBasket")
    @ResponseBody
    public String insertBasket(@RequestBody BasketEntity basket, Model model) { 
        basketService.insertBasket(basket); 
        return "basket/basket";
    }

    @PutMapping("/updateBasket")
    @ResponseBody
    public String updateBasket(@RequestBody BasketEntity basket) { 
        basketService.updateBasket(basket); 
        return "Updated";
    }

    @DeleteMapping("/deleteBasket/{productCode}/{userId}")
    @ResponseBody
    public String deleteBasket(@PathVariable String productCode, @PathVariable Integer userId) { 
        basketService.deleteBasket(productCode, userId); 
        return "Deleted";
    }
}
