package com.saeromteo.app.model.product;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProductCategoryEntity {
	private Integer categoryNumber;
    private String majorCategory;
    private String middleCategory;
    private String smallCategory;
}
