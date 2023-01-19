package com.example.demo.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin(value = "*")
public class DemoController {

    @GetMapping("/testing")
    public ResponseEntity<String> TestingMethod() {
        return new ResponseEntity<String>("Success", HttpStatus.OK);
    }
}
