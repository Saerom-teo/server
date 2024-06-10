package com.saeromteo.app.service.basket;

import com.saeromteo.app.dto.basket.BasketDTO.BasketResponse;
import com.saeromteo.app.dto.basket.BasketDTO.BasketRequest;
import com.saeromteo.app.dao.basket.BasketDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BasketService {

    @Autowired
    BasketDAO basketDAO;

    public List<BasketResponse> readAll() {
        return basketDAO.readAll();
    }

    public BasketResponse readByProductCodeAndUserId(int productCode, int userId) {
        return basketDAO.readByProductCodeAndUserId(productCode, userId);
    }

    public int insertBasket(BasketRequest basket) {
       return basketDAO.insertBasket(basket);
    }

    public int updateBasket(BasketRequest basket) {
       return basketDAO.updateBasket(basket);
    }

    public int deleteBasket(int productCode, int userId) {
       return basketDAO.deleteBasket(productCode, userId);
    }
}
