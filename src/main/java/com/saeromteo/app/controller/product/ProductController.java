package com.saeromteo.app.controller.product;

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
import org.springframework.web.bind.annotation.RequestParam;

import com.saeromteo.app.model.product.ProductEntity;
import com.saeromteo.app.service.product.ProductService;

@Controller
@RequestMapping("/products")
public class ProductController {

    @Autowired
    ProductService productService;
    
    @GetMapping(value="", produces = "application/json")
    public String getAllProducts(@RequestParam(required = false) String sortBy, Model model) {
        List<ProductEntity> productList;

        if (sortBy != null && !sortBy.isEmpty()) {
            productList = productService.readAllSorted(sortBy);
        } else {
            productList = productService.readAll();
        }
        
        model.addAttribute("productList", productList);
        return "product/product";
    }
    
    @GetMapping(value = "/{productCode}")
    public String readByProductCode(@PathVariable Integer productCode, Model model) {
    	ProductEntity productDetail = productService.readByProductCode(productCode);
        model.addAttribute("product", productDetail);
        return "product/product-detail";
    }
    
    @GetMapping(value = "/review")
	 public String test2() {
		return "product/product-detail-review";
	}
    
    @GetMapping(value="/readByCategory/{categoryNumber}", produces = "application/json")
    public List<ProductEntity> readByCategory(@PathVariable Integer categoryNumber) {
        return productService.readByCategory(categoryNumber);
    }
    
    @GetMapping(value="/readByParentCategory/{parentCategoryNumber}", produces = "application/json")
    public List<ProductEntity> readByParentCategory(@PathVariable Integer parentCategoryNumber) {
        return productService.readByParentCategory(parentCategoryNumber);
    }


    @PostMapping(value = "/insertProduct", produces =  "text/plain;charset=utf-8", consumes = "application/json")
    public String insertProduct(@RequestBody ProductEntity product) {
    	int result = productService.insertProduct(product);
    	return result + "";
    }

    @PutMapping(value = "/updateProduct", produces =  "text/plain;charset=utf-8", consumes = "application/json")
    public String productUpdate(@RequestBody ProductEntity product) {
    	int result = productService.updateProduct(product);
    	return result + "";
    }

    @DeleteMapping(value = "/deleteProduct/{productCode}", produces =  "text/plain;charset=utf-8")
    public String deleteProduct(@PathVariable Integer productCode) {
    	int result = productService.deleteProduct(productCode);
    	return result + "";
    }
    
    @GetMapping(value="/readAllPaged", produces = "application/json")
    public List<ProductEntity> readAllPaged(@RequestParam int page, @RequestParam int size) {
        return productService.readAllPaged(page, size);
    }
    
    
    
}
