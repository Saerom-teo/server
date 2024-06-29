package com.saeromteo.app.controller.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.saeromteo.app.dto.review.ReviewDto;
import com.saeromteo.app.model.product.ProductEntity;
import com.saeromteo.app.service.product.ProductCategoryService;
import com.saeromteo.app.service.product.ProductService;
import com.saeromteo.app.service.review.ReviewService;

@Controller
@RequestMapping("/products")
public class ProductController {

    @Autowired
    ProductService productService;
    
    @Autowired
    ProductCategoryService productCategoryService;
    
    @Autowired
    ReviewService reviewService;
    
    
    @GetMapping(value="", produces = "application/json")
    public String getAllProducts(@RequestParam(required = false) String sortBy, Model model) {
        List<ProductEntity> productList;

        if (sortBy != null && !sortBy.isEmpty()) {
            productList = productService.readAllSorted(sortBy);
        } else {
            productList = productService.readAll();
        }
        List<String> majorResult = productCategoryService.readAll_major();
        model.addAttribute("major",majorResult);
        model.addAttribute("middle", productCategoryService.readAll_middle());
        model.addAttribute("category", productCategoryService.readAll());
        
         
        model.addAttribute("productList", productList);
        return "product/product";
    }
    
    @GetMapping(value = "/{productCode}")
    public String readByProductCode(@PathVariable Integer productCode, Model model) {
    	ProductEntity productDetail = productService.readByProductCode(productCode);
        model.addAttribute("product", productDetail);
        return "product/product-detail";
    }
    
    @GetMapping(value = "/review/{productCode}")
	 public String readProductReview(@PathVariable("productCode") String productCode, Model model) {
    	List<ReviewDto.ReviewResponse> reviewList = reviewService.readProductReview(productCode);
    	model.addAttribute("reviewList", reviewList);
    	
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
    
    // 소분류, 중분류, 대분류로 조회
    @GetMapping(value="/selectBySmallCategory", produces = "application/json")
    public List<ProductEntity> selectBySmallCategory(@RequestParam String majorCategory, @RequestParam String middleCategory, @RequestParam String smallCategory) {
        return productService.selectBySmallCategory(majorCategory, middleCategory, smallCategory);
    }

    @GetMapping(value="/selectByMiddleCategory", produces = "application/json")
    public List<ProductEntity> selectByMiddleCategory(@RequestParam String majorCategory, @RequestParam String middleCategory) {
        return productService.selectByMiddleCategory(majorCategory, middleCategory);
    }

    @GetMapping(value="/selectByMajorCategory", produces = "application/json")
    public List<ProductEntity> selectByMajorCategory(@RequestParam String majorCategory) {
        return productService.selectByMajorCategory(majorCategory);
    }
    
    @GetMapping(value = "/byCategory", produces = "application/json")
    public List<ProductEntity> getProductsByCategory(@RequestParam String categoryType, @RequestParam String majorCategory, @RequestParam(required = false) String middleCategory, @RequestParam(required = false) String smallCategory) {
        switch (categoryType) {
            case "major":
                return productService.selectByMajorCategory(majorCategory);
            case "middle":
                return productService.selectByMiddleCategory(majorCategory, middleCategory);
            case "small":
                return productService.selectBySmallCategory(majorCategory, middleCategory, smallCategory);
            default:
                return null;
        }
    }
    
}
