package com.saeromteo.app.dto.wishlist;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

public class WishlistDTO {
    @Getter
    @Setter
    @ToString
    static public class WishlistResponse {
        private String productCode;
        private Integer userId;
    }

    @Getter
    @Setter
    @ToString
    static public class WishlistRequest {
        private String productCode;
        private Integer userId;
    }
}
