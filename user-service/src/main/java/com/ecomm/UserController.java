package com.ecomm;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.ResponseEntity;

@RestController
public class UserController {
    @GetMapping("/users")
    public ResponseEntity<String> getUsers() {
        try {
            return ResponseEntity.ok("{\"id\": 1, \"name\": \"Charan\"}");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("{\"error\": \"User Service failed\"}");
        }
    }
}
