package com.saeromteo.app.service.basket;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.basket.BasketDAO;
import com.saeromteo.app.model.basket.BasketEntity;

@Service
public class BasketService {

    @Autowired
    BasketDAO basketDAO;

    public List<BasketEntity> readAll() {
        return basketDAO.readAll(); 
    }
    public List<BasketEntity> basketListUser(int userId) {
        return basketDAO.basketListUser(userId); 
    }

    public List<BasketEntity> readByUserId(int userId) {
        return basketDAO.readByUserId(userId); 
    }

    public int insertBasket(BasketEntity basket) { 
        return basketDAO.insertBasket(basket); 
    }

    public int updateBasket(BasketEntity basket) { 
        return basketDAO.updateBasket(basket); 
    }

    public int deleteBasket(String productCode, int userId) { 
        return basketDAO.deleteBasket(productCode, userId); 
    }
}
