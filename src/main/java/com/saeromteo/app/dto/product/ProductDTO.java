package com.saeromteo.app.dto.product;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class ProductDTO {

	static public class Product {

		int productCode;
		int productPrice;
		int stockQuantity;
		Date registrationDate;
		String envMark;
		String thumbnail;
		String detailImage;
		int categoryNumber;
		int discountCode;
	}

}
