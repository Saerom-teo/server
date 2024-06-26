package com.saeromteo.app.service.product;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.product.DiscountDAO;
import com.saeromteo.app.model.product.DiscountEntity;

@Service
public class DiscountService {

    @Autowired
    DiscountDAO discountDAO;

    public List<DiscountEntity> readAll() {
        return discountDAO.readAll();
    }

    public DiscountEntity readById(int discountCode) {
        return discountDAO.readById(discountCode);
    }

    public int insertDiscount(DiscountEntity discount) {
       return discountDAO.insertDiscount(discount);
    }

    public int updateDiscount(DiscountEntity discount) {
       return discountDAO.updateDiscount(discount);
    }

    public int deleteDiscount(int discountCode) {
       return discountDAO.deleteDiscount(discountCode);
    }
}
