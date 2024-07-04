package com.saeromteo.app.model.basket;

import com.saeromteo.app.model.product.DiscountEntity;
import com.saeromteo.app.model.product.ProductEntity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BasketEntity {
    private String productCode; // 기존 Integer에서 String으로 수정
    private Integer userId;
    private Integer productQuantity;
    
    // 데이터 보여주기 위해 추가
    private ProductEntity product;
    private DiscountEntity discount;
}
