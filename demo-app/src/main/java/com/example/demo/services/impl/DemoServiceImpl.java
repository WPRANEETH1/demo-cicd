package com.example.demo.services.impl;

import com.example.demo.services.DemoService;
import org.springframework.stereotype.Service;

@Service
public class DemoServiceImpl implements DemoService {


    @Override
    public Integer smallCalculator(int a, int b) {
        return a + b;
    }
}
