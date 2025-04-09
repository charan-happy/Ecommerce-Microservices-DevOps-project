package main

import (
    "fmt"
    "net/http"
    "io"
    "encoding/json"
)

func recommendHandler(w http.ResponseWriter, r *http.Request) {
    resp, err := http.Get("http://localhost:3000/products")
    if err != nil {
        http.Error(w, "Error: Product Service unavailable", 503)
        return
    }
    defer resp.Body.Close()
    if resp.StatusCode != http.StatusOK {
        http.Error(w, "Error: Product Service failed", resp.StatusCode)
        return
    }
    body, err := io.ReadAll(resp.Body)
    if err != nil {
        http.Error(w, "Error: Failed to read product data", 500)
        return
    }
    var product map[string]interface{}
    if err := json.Unmarshal(body, &product); err != nil {
        http.Error(w, "Error: Invalid product data", 500)
        return
    }
    fmt.Fprintf(w, "Recommended: %v", product["name"])
}

func main() {
    http.HandleFunc("/recommend", recommendHandler)
    fmt.Println("Recommend Service running on port 8081")
    http.ListenAndServe(":8081", nil)
}
