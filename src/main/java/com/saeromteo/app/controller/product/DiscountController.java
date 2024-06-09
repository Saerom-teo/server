package com.saeromteo.app.controller.product;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.saeromteo.app.dto.product.DiscountDTO.DiscountRequest;
import com.saeromteo.app.dto.product.DiscountDTO.DiscountResponse;
import com.saeromteo.app.service.product.DiscountService;

import java.util.List;

@RestController
@RequestMapping("/discount")
public class DiscountController {

    @Autowired
    DiscountService discountService;

    @GetMapping(value="/readAll", produces = "application/json")
    public List<DiscountResponse> readAll() {
        return discountService.readAll();
    }

    @GetMapping(value="/readById/{discountId}", produces = "application/json")
    public DiscountResponse readById(@PathVariable Integer discountId) {
        return discountService.readById(discountId);
    }

    @PostMapping(value = "/insertDiscount", produces =  "text/plain;charset=utf-8", consumes = "application/json")
    public String insertDiscount(@RequestBody DiscountRequest discount) {
        int result = discountService.insertDiscount(discount);
        return result + "개의 할인 항목이 추가되었습니다.";
    }

    @PutMapping(value = "/updateDiscount", produces =  "text/plain;charset=utf-8", consumes = "application/json")
    public String updateDiscount(@RequestBody DiscountRequest discount) {
        int result = discountService.updateDiscount(discount);
        return result + "개의 할인 항목이 업데이트되었습니다.";
    }

    @DeleteMapping(value = "/deleteDiscount/{discountId}", produces =  "text/plain;charset=utf-8")
    public String deleteDiscount(@PathVariable Integer discountId) {
        int result = discountService.deleteDiscount(discountId);
        return result + "개의 할인 항목이 삭제되었습니다.";
    }
}
