package com.saeromteo.app.controller.product;

import com.saeromteo.app.dto.product.ProductDTO.ProductResponse;
import com.saeromteo.app.service.product.ProductService;
import com.saeromteo.app.dto.product.ProductDTO.ProductRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/*@RestController*/
@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    ProductService productService;
    
	@GetMapping(value = "/test")
	 public String test() {
		return "product/product-detail-review";
	}

    @GetMapping(value="/readAll", produces = "application/json")
    public List<ProductResponse> readAll() {
        return productService.readAll();
    }

    @GetMapping(value="/readByProductCode/{productCode}", produces = "application/json")
    public ProductResponse readByProductCode(@PathVariable Integer productCode) {
        return productService.readByProductCode(productCode);
    }

    @GetMapping(value="/readByCategory/{categoryNumber}", produces = "application/json")
    public List<ProductResponse> readByCategory(@PathVariable Integer categoryNumber) {
        return productService.readByCategory(categoryNumber);
    }
    
    @GetMapping(value="/readByParentCategory/{parentCategoryNumber}", produces = "application/json")
    public List<ProductResponse> readByParentCategory(@PathVariable Integer parentCategoryNumber) {
        return productService.readByParentCategory(parentCategoryNumber);
    }


    @PostMapping(value = "/insertProduct", produces =  "text/plain;charset=utf-8", consumes = "application/json")
    public String insertProduct(@RequestBody ProductRequest product) {
    	int result = productService.insertProduct(product);
    	return result + "";
    }

    @PutMapping(value = "/updateProduct", produces =  "text/plain;charset=utf-8", consumes = "application/json")
    public String productUpdate(@RequestBody ProductRequest product) {
    	int result = productService.updateProduct(product);
    	return result + "";
    }

    @DeleteMapping(value = "/deleteProduct/{productCode}", produces =  "text/plain;charset=utf-8")
    public String deleteProduct(@PathVariable Integer productCode) {
    	int result = productService.deleteProduct(productCode);
    	return result + "";
    }
    
    @GetMapping(value="/readAllPaged", produces = "application/json")
    public List<ProductResponse> readAllPaged(@RequestParam int page, @RequestParam int size) {
        return productService.readAllPaged(page, size);
    }
    
}
