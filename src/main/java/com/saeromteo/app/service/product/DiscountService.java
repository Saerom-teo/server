package com.saeromteo.app.service.product;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.product.DiscountDAO;
import com.saeromteo.app.dto.product.DiscountDTO.DiscountRequest;
import com.saeromteo.app.dto.product.DiscountDTO.DiscountResponse;

import java.util.List;

@Service
public class DiscountService {

    @Autowired
    DiscountDAO discountDAO;

    public List<DiscountResponse> readAll() {
        return discountDAO.readAll();
    }

    public DiscountResponse readById(int discountId) {
        return discountDAO.readById(discountId);
    }

    public int insertDiscount(DiscountRequest discount) {
       return discountDAO.insertDiscount(discount);
    }

    public int updateDiscount(DiscountRequest discount) {
       return discountDAO.updateDiscount(discount);
    }

    public int deleteDiscount(int discountId) {
       return discountDAO.deleteDiscount(discountId);
    }
}
