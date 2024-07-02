package com.saeromteo.app.controller.product;

import java.util.ArrayList;
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
import com.saeromteo.app.dto.review.ReviewDto;
import com.saeromteo.app.dto.review.ReviewDto.ReviewResponse;
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
    public String readByProductCode(@PathVariable String productCode, Model model) {
    	ProductEntity productDetail = productService.readByProductCode(productCode);
        model.addAttribute("product", productDetail);
        return "product/product-detail";
    }
    
    @GetMapping(value = "/review/{productCode}")
	 public String readProductReview(@PathVariable("productCode") String productCode, Model model) {
    	List<ReviewDetailDto> reviewDetailList = new ArrayList<ReviewDetailDto>();
    	
    	
    	for(ReviewResponse review : reviewService.readProductReview(productCode)) {
    		ReviewDetailDto dto = new ReviewDetailDto(review);
    		reviewDetailList.add(dto);
    	}
    	
    	model.addAttribute("productCode", productCode);
    	model.addAttribute("reviewList", reviewDetailList);
    	model.addAttribute("reviewCount", reviewService.readCountScore(productCode));
    	model.addAttribute("reviewAvg", reviewService.readAvgScore(productCode));
    	
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
    @ResponseBody
    public List<ProductEntity> getProductsByCategory(@RequestParam String categoryType, 
    		@RequestParam(required = false) String majorCategory, @RequestParam(required = false) String middleCategory, 
    		@RequestParam(required = false) String smallCategory) {
    	
        switch (categoryType) {
            case "major":
                return productService.selectByMajorCategory(majorCategory);
            case "middle":
                return productService.selectByMiddleCategory(majorCategory, middleCategory);
            case "small":
                return productService.selectBySmallCategory(majorCategory, middleCategory, smallCategory);
            case "all": 
            	System.out.println(productService.readAll());
                return productService.readAll();
            default:
                return null;
        }
    }
}
