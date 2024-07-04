package com.saeromteo.app.controller.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.saeromteo.app.dto.review.ReviewDetailDto;
import com.saeromteo.app.model.product.ProductCategoryEntity;
import com.saeromteo.app.model.product.ProductEntity;
import com.saeromteo.app.service.product.ProductCategoryService;
import com.saeromteo.app.service.product.ProductService;
import com.saeromteo.app.service.review.ReviewService;
import com.saeromteo.app.service.user.UserService;

@Controller
@RequestMapping("/products")
public class ProductController {

    @Autowired
    ProductService productService;
    
    @Autowired
    ProductCategoryService productCategoryService;
    
    @Autowired
    ReviewService reviewService;
    
    @Autowired
    UserService userService;
    
    @GetMapping(value="", produces = "application/json")
    public String getAllProducts(@RequestParam(required = false) String sortBy, Model model) {
     
        List<String> majorResult = productCategoryService.readAll_major();
        model.addAttribute("major",majorResult);
        model.addAttribute("middle", productCategoryService.readAll_middle());
        model.addAttribute("category", productCategoryService.readAll());   
        
        return "product/product";
    }
    
    @GetMapping(value = "/{productCode}")
    public String readByProductCode(@PathVariable String productCode, Model model) {
    	System.out.println(productCode);
    	
    	ProductEntity productDetail = productService.readByProductCode(productCode);
        model.addAttribute("product", productDetail);
        
        
        // 상품의 카테고리 정보 가져오기
        List<ProductCategoryEntity> categoryList = productCategoryService.readCategoriesByProductCode(productCode);
        model.addAttribute("categoryList", categoryList);
        
        return "product/product-detail";
    }
    
    @GetMapping(value = "/review/{productCode}")
	 public String readProductReview(@PathVariable("productCode") String productCode, Model model) {
    	Integer userId = 1;
    	
    	List<ReviewDetailDto> reviewDetailList = reviewService.readProductReview(productCode);
    	int readIsOrder = reviewService.readIsOrder(productCode, userId);
    	boolean isOrder = false;
    	if(readIsOrder == 1) isOrder = true;
    	
    	model.addAttribute("productCode", productCode);
    	model.addAttribute("reviewList", reviewDetailList);
    	model.addAttribute("reviewCount", reviewService.readCountScore(productCode));
    	model.addAttribute("reviewAvg", reviewService.readAvgScore(productCode));
    	model.addAttribute("isOrder", isOrder);
    	
    	ProductEntity productDetail = productService.readByProductCode(productCode);
        model.addAttribute("product", productDetail);
        
        
        // 상품의 카테고리 정보 가져오기
        List<ProductCategoryEntity> categoryList = productCategoryService.readCategoriesByProductCode(productCode);
        model.addAttribute("categoryList", categoryList);
    	
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
    
    @GetMapping(value="/readByKeyword/{keyword}")
    public String readByKeyword(@PathVariable("keyword") String keyword, Model model) {
    	List<ProductEntity> productList = productService.readByKeyword(keyword);
    	boolean isExist = true;
    	
    	Integer productLength = productList.size();
    	
    	model.addAttribute("productLength", productLength);
    	
    	if(productLength == 0) {
    		isExist = false;
    		productList = productService.readAll();
    	}
    	
    	model.addAttribute("productList", productList);
    	model.addAttribute("keyword", keyword);
    	model.addAttribute("isExist", isExist);
    	
    	return "product/product-search";
    }


    @PostMapping(value = "/insertProduct", produces = "text/plain;charset=utf-8", consumes = "application/json")
    public ResponseEntity<String> insertProduct(@RequestBody ProductEntity product) {
        int result = productService.insertProduct(product);
        return ResponseEntity.ok(result + "개의 상품이 추가되었습니다.");
    }

    @PutMapping(value = "/updateProduct", produces = "application/json", consumes = "application/json")
    @ResponseBody
    public String updateProduct(@RequestBody ProductEntity product) {
        int result = productService.updateProduct(product);
        if (result > 0) {
            return "상품 정보가 성공적으로 업데이트되었습니다.";
        } else {
            return "상품 정보 업데이트에 실패했습니다.";
        }
    }

    @DeleteMapping(value = "/deleteProduct/{productCode}", produces =  "text/plain;charset=utf-8")
    public ResponseEntity<String> deleteProduct(@PathVariable Integer productCode) {
    	int result = productService.deleteProduct(productCode);
    	if (result > 0) {
            return ResponseEntity.ok("Product deleted successfully.");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Product not found.");
        }
    }
    
    @GetMapping(value="/readAllPaged", produces = "application/json")
    public List<ProductEntity> readAllPaged(@RequestParam int page, @RequestParam int size) {
        return productService.readAllPaged(page, size);
    }
    
    // 소분류, 중분류, 대분류로 조회

    //조회 
    @GetMapping(value = "/byCategory", produces = "application/json")
    @ResponseBody
    public List<ProductEntity> getProductsByCategory(@RequestParam String categoryType, 
    		@RequestParam(required = false) String majorCategory, @RequestParam(required = false) String middleCategory, 
    		@RequestParam(required = false) String smallCategory ) {
    	
    	if(categoryType.equals("all")) {
    		return productService.readAll();
    	}else {
    		return productService.selectBySmallCategory(majorCategory, middleCategory, smallCategory, categoryType);
    	}
    }
}
