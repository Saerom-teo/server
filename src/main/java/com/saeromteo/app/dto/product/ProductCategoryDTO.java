package com.saeromteo.app.dto.product;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

public class ProductCategoryDTO {
    @Getter
    @Setter
    @ToString
    static public class ProductCategoryResponse {
    	 private Integer categoryNumber;
         private String categoryName;
    }

    @Getter
    @Setter
    @ToString
    static public class ProductCategoryRequest {
    	  private Integer categoryNumber;
          private String categoryName;
    }
}
