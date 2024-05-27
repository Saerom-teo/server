package com.shinhan.myapp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.myapp.dao.TestDao;

import java.util.List;

@Service
public class NumberService {

    @Autowired
    private TestDao numberRepository;

    public List<Integer> getAllNumbers() {
        return numberRepository.test();
    }
}
