package com.saeromteo.app.controller.product;

import com.saeromteo.app.dto.product.ProductCategoryDTO.ProductCategoryResponse;
import com.saeromteo.app.service.product.ProductCategoryService;
import com.saeromteo.app.dto.product.ProductCategoryDTO.ProductCategoryRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/productcategory")
public class ProductCategoryController {

    @Autowired
    ProductCategoryService productCategoryService;

    @GetMapping(value="/readAll", produces = "application/json")
    public List<ProductCategoryResponse> readAll() {
        return productCategoryService.readAll();
    }

    @GetMapping(value="/readByCategoryNumber/{categoryNumber}", produces = "application/json")
    public ProductCategoryResponse readByCategoryNumber(@PathVariable Integer categoryNumber) {
        return productCategoryService.readByCategoryNumber(categoryNumber);
    }

    @PostMapping(value = "/insertCategory", produces =  "text/plain;charset=utf-8", consumes = "application/json")
    public String insertCategory(@RequestBody ProductCategoryRequest category) {
        int result = productCategoryService.insertCategory(category);
        return result + "개의 카테고리가 추가되었습니다.";
    }

    @PutMapping(value = "/updateCategory", produces =  "text/plain;charset=utf-8", consumes = "application/json")
    public String updateCategory(@RequestBody ProductCategoryRequest category) {
        int result = productCategoryService.updateCategory(category);
        return result + "개의 카테고리가 업데이트되었습니다.";
    }

    @DeleteMapping(value = "/deleteCategory/{categoryNumber}", produces =  "text/plain;charset=utf-8")
    public String deleteCategory(@PathVariable Integer categoryNumber) {
        int result = productCategoryService.deleteCategory(categoryNumber);
        return result + "개의 카테고리가 삭제되었습니다.";
    }
}
