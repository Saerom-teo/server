package com.saeromteo.app.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.TestDao;

import java.util.List;

@Service
public class NumberService {

    @Autowired
    private TestDao numberRepository;

    public List<Integer> getAllNumbers() {
        return numberRepository.test();
    }
}
