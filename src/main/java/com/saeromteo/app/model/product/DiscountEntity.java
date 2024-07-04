package com.saeromteo.app.model.product;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DiscountEntity {
	private Integer discountCode;
    private Double discountRate;
    private String discountStart;
    private String discountEnd;
    private String discountName;
}
