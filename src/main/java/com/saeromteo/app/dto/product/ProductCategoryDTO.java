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
        private String pcategoryName;
        private Integer pcategoryLevel;
        private Integer pcategoryHigh;
    }

    @Getter
    @Setter
    @ToString
    static public class ProductCategoryRequest {
        private String pcategoryName;
        private Integer pcategoryLevel;
        private Integer pcategoryHigh;
    }
}
