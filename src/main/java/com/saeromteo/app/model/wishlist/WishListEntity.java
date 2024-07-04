package com.saeromteo.app.model.wishlist;

import com.saeromteo.app.model.product.DiscountEntity;
import com.saeromteo.app.model.product.ProductEntity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class WishListEntity {
	private String productCode;
    private Integer userId;

    // 데이터 보여주기 위해 추가
    private ProductEntity product;
    private DiscountEntity discount;
}
