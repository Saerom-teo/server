package com.saeromteo.app.dto.product;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

public class DiscountDTO {
    @Getter
    @Setter
    @ToString
    static public class DiscountResponse {
        private Integer discountId;
        private Double discountRate;
        private String discountStart;
        private String discountEnd;
        private String discountName;
    }

    @Getter
    @Setter
    @ToString
    static public class DiscountRequest {
        private Double discountRate;
        private String discountStart;
        private String discountEnd;
        private String discountName;
    }
}
