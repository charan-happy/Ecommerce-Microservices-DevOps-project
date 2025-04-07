package main

import (
    "fmt"
    "net/http"
)

func recommendHandler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hello from Recommend Service!")
}

func main() {
    http.HandleFunc("/recommend", recommendHandler)
    fmt.Println("Recommend Service running on port 8081")
    http.ListenAndServe(":8081", nil)
}
