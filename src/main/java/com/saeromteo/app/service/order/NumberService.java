package com.saeromteo.app.service.order;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.order.TestDao;

import java.util.List;

@Service
public class NumberService {

    @Autowired
    private TestDao numberRepository;

    public List<Integer> getAllNumbers() {
        return numberRepository.test();
    }
}
