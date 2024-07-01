package com.saeromteo.app.controller.product;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.saeromteo.app.model.product.DiscountEntity;
import com.saeromteo.app.model.product.ProductCategoryEntity;
import com.saeromteo.app.service.product.ProductCategoryService;

@RestController
@RequestMapping("/productcategory")
public class ProductCategoryController {

    @Autowired
    ProductCategoryService productCategoryService;

    @GetMapping(value="/readAll", produces = "application/json")
    public List<ProductCategoryEntity> readAll() {
        return productCategoryService.readAll();
    }

    @GetMapping(value="/readByCategoryNumber/{categoryNumber}", produces = "application/json")
    public ProductCategoryEntity readByCategoryNumber(@PathVariable Integer categoryNumber) {
        return productCategoryService.readByCategoryNumber(categoryNumber);
    }

    @PostMapping(value = "/insertCategory", produces =  "text/plain;charset=utf-8", consumes = "application/json")
    public String insertCategory(@RequestBody ProductCategoryEntity category) {
        int result = productCategoryService.insertCategory(category);
        return result + "개의 카테고리가 추가되었습니다.";
    }

    @PutMapping(value = "/updateCategory", produces =  "text/plain;charset=utf-8", consumes = "application/json")
    public String updateCategory(@RequestBody ProductCategoryEntity category) {
        int result = productCategoryService.updateCategory(category);
        return result + "개의 카테고리가 업데이트되었습니다.";
    }

    @DeleteMapping(value = "/deleteCategory/{categoryNumber}", produces =  "text/plain;charset=utf-8")
    public String deleteCategory(@PathVariable Integer categoryNumber) {
        int result = productCategoryService.deleteCategory(categoryNumber);
        return result + "개의 카테고리가 삭제되었습니다.";
    }
    
    //카테고리 조회
    @GetMapping(value="/readByCategoryDetails", produces = "application/json")
    public List<ProductCategoryEntity> readByCategoryDetails(@RequestParam String majorCategory, @RequestParam String middleCategory, @RequestParam String smallCategory) {
        return productCategoryService.readByCategoryDetails(majorCategory, middleCategory, smallCategory);
    }
}
