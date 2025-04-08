package com.ecomm;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserController {
    @GetMapping("/users")
    public String getUsers() {
        return "{\"id\": 1, \"name\": \"Charan\"}";
    }
}
