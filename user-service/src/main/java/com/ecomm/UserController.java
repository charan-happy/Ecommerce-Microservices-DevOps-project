package com.ecomm;

import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import java.util.*;
import java.util.concurrent.atomic.AtomicLong;

@RestController
@RequestMapping("/users")
public class UserController {
    private final List<Map<String, Object>> users = new ArrayList<>();
    private final AtomicLong counter = new AtomicLong(1);

    public UserController() {
        // Seed initial user
        Map<String, Object> user = new HashMap<>();
        user.put("id", counter.getAndIncrement());
        user.put("name", "Charan");
        users.add(user);
    }

    // GET all users
    @GetMapping
    public ResponseEntity<List<Map<String, Object>>> getAllUsers() {
        try {
            return ResponseEntity.ok(users);
        } catch (Exception e) {
            return ResponseEntity.status(500).body(null);
        }
    }

    // GET user by ID
    @GetMapping("/{id}")
    public ResponseEntity<Map<String, Object>> getUserById(@PathVariable Long id) {
        try {
            Optional<Map<String, Object>> user = users.stream()
                    .filter(u -> u.get("id").equals(id))
                    .findFirst();
            return user.map(ResponseEntity::ok)
                    .orElseGet(() -> ResponseEntity.status(404).body(null));
        } catch (Exception e) {
            return ResponseEntity.status(500).body(null);
        }
    }

    // POST new user
    @PostMapping
    public ResponseEntity<Map<String, Object>> createUser(@RequestBody Map<String, String> payload) {
        try {
            String name = payload.get("name");
            if (name == null || name.isEmpty()) {
                return ResponseEntity.status(400).body(null);
            }
            Map<String, Object> user = new HashMap<>();
            user.put("id", counter.getAndIncrement());
            user.put("name", name);
            users.add(user);
            return ResponseEntity.status(201).body(user);
        } catch (Exception e) {
            return ResponseEntity.status(500).body(null);
        }
    }

    // PUT update user
    @PutMapping("/{id}")
    public ResponseEntity<Map<String, Object>> updateUser(@PathVariable Long id, @RequestBody Map<String, String> payload) {
        try {
            String name = payload.get("name");
            if (name == null || name.isEmpty()) {
                return ResponseEntity.status(400).body(null);
            }
            Optional<Map<String, Object>> userOpt = users.stream()
                    .filter(u -> u.get("id").equals(id))
                    .findFirst();
            if (userOpt.isPresent()) {
                Map<String, Object> user = userOpt.get();
                user.put("name", name);
                return ResponseEntity.ok(user);
            }
            return ResponseEntity.status(404).body(null);
        } catch (Exception e) {
            return ResponseEntity.status(500).body(null);
        }
    }

    // DELETE user
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
        try {
            boolean removed = users.removeIf(u -> u.get("id").equals(id));
            return removed ? ResponseEntity.noContent().build()
                    : ResponseEntity.status(404).build();
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }
}
