package com.saeromteo.app.dto.basket;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

public class BasketDTO {
    @Getter
    @Setter
    @ToString
    static public class BasketResponse {
        private Integer productCode;
        private Integer userId;
        private Integer productQuantity;
    }

    @Getter
    @Setter
    @ToString
    static public class BasketRequest {
        private Integer productCode;
        private Integer userId;
        private Integer productQuantity;
    }
}
