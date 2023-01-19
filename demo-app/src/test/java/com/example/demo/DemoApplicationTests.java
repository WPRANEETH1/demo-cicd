package com.example.demo;

import com.example.demo.services.DemoService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.io.IOException;

@SpringBootTest
class DemoApplicationTests {

    @Autowired
    DemoService demoService;

    @Test
    void contextLoads() {
    }

    @Test
    void addProjectMember() throws IOException, InterruptedException {
        Integer response = demoService.smallCalculator(10, 6);
        assertTrue(response == 16);
    }


}
