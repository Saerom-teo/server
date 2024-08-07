package com.saeromteo.app.dto.product;

import java.sql.Date;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

public class ProductDTO {
	@Getter
	@Setter
	@ToString
	static public class ProductResponse {
		private String productCode; 
		private String productName;
		private Integer productPrice;
		private Integer stockQuantity;
		private Date registrationDate; 
		private String envMark;
		private String thumbnail;
		private String detailImage;
		private Integer categoryNumber;
		private Integer discountCode;
	    private Double discountRate;
	    private Integer discountedPrice; 
	}
	@Getter
	@Setter
	@ToString
	static public class ProductRequest {
		private String productCode;
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
