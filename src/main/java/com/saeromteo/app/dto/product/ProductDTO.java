package com.saeromteo.app.dto.product;

import java.sql.Date;
import java.util.List;

import com.saeromteo.app.model.order.OrderProductDto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

public class ProductDTO {
	@Getter
	@Setter
	@ToString
	static public class ProductResponse {
		private Integer productCode;
		private String productName;
		private Integer productPrice;
		private Integer stockQuantity;
		private Date registrationDate; 
		private String envMark;
		private String thumbnail;
		private String detailImage;
		private Integer categoryNumber;
		private Integer discountCode;
	}
	@Getter
	@Setter
	@ToString
	static public class ProductRequest {
		private Integer productCode;
	    private String productName;
	    private Integer productPrice;
	    private Integer stockQuantity;
	    private Date registrationDate;
	    private String envMark;
	    private String thumbnail;
	    private String detailImage;
	    private Integer categoryNumber;
	    private Integer discountCode;

	}

}
