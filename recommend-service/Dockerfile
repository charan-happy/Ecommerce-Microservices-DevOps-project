# Build stage
FROM golang:1.22-alpine AS builder
WORKDIR /app

# Copy go.mod and go.sum first to leverage caching
COPY go.mod go.sum ./
RUN go mod download

# Copy source files and build the application
COPY . .
# Go binary with static linking
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o recommend-service .

# Final stage with minimal image
FROM alpine:latest
WORKDIR /app

# Copy built binary from builder stage
COPY --from=builder /app/recommend-service .

# Expose port and set entrypoint
EXPOSE 8081
ENTRYPOINT ["/app/recommend-service"]
