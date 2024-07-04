package com.saeromteo.app.model.product;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProductEntity {
	private String productCode; 
	private String productName;
	private Integer productPrice;
	private Integer stockQuantity;
	private Date registrationDate; 
	private String envMark; // 환경인증마크
	private String thumbnail;
	private String detailImage;
	private Integer categoryNumber;
	private Integer discountCode;
    private Double discountRate;
    private Integer discountedPrice; 
    private String brand;
    private int wishCount; // 위시리스트 좋아요 수
    
    private Integer productQuantity; // 장바구니 상품 수량
    
    private ProductCategoryEntity category;
    
}
