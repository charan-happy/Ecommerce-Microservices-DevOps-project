package main

import (
    "fmt"
    "net/http"
    "io/ioutil"
    "encoding/json"
)

func recommendHandler(w http.ResponseWriter, r *http.Request) {
    resp, err := http.Get("http://localhost:3000/products")
    if err != nil {
        http.Error(w, "Failed to fetch product", 500)
        return
    }
    defer resp.Body.Close()
    body, _ := ioutil.ReadAll(resp.Body)
    var product map[string]interface{}
    json.Unmarshal(body, &product)
    fmt.Fprintf(w, "Recommended: %v", product["name"])
}

func main() {
    http.HandleFunc("/recommend", recommendHandler)
    fmt.Println("Recommend Service running on port 8081")
    http.ListenAndServe(":8081", nil)
}
