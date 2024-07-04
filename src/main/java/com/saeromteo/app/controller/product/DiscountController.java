package com.saeromteo.app.controller.product;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.saeromteo.app.model.product.DiscountEntity;
import com.saeromteo.app.service.product.DiscountService;

@RestController
@RequestMapping("/discount")
public class DiscountController {

    @Autowired
    DiscountService discountService;

    @GetMapping(value="/readAll", produces = "application/json")
    public List<DiscountEntity> readAll() {
        return discountService.readAll();
    }

    @GetMapping(value="/readById/{discountId}", produces = "application/json")
    public DiscountEntity readById(@PathVariable Integer discountCode) {
        return discountService.readById(discountCode);
    }

    @PostMapping(value = "/insertDiscount", produces =  "text/plain;charset=utf-8", consumes = "application/json")
    public String insertDiscount(@RequestBody DiscountEntity discount) {
        int result = discountService.insertDiscount(discount);
        return result + "개의 할인 항목이 추가되었습니다.";
    }

    @PutMapping(value = "/updateDiscount", produces =  "text/plain;charset=utf-8", consumes = "application/json")
    public String updateDiscount(@RequestBody DiscountEntity discount) {
        int result = discountService.updateDiscount(discount);
        return result + "개의 할인 항목이 업데이트되었습니다.";
    }

    
    @DeleteMapping(value = "/deleteDiscount/{discountCode}", produces =  "text/plain;charset=utf-8")
    public ResponseEntity<String> deleteDiscount(@PathVariable Integer discountCode) {
        try {
            int result = discountService.deleteDiscount(discountCode);
            if (result > 0) {
                return ResponseEntity.ok(result + "개의 할인 항목이 삭제되었습니다.");
            } else {
                return ResponseEntity.status(404).body("해당 할인 항목을 찾을 수 없습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();  // 서버 로그에 예외 메시지를 출력합니다.
            return ResponseEntity.status(500).body("서버 오류가 발생했습니다.");
        }
    }
    
}
