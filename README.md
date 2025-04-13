A DevOps Project to build a scalable app.


Documentation for this project can be found at [GITBOOK](https://50-days-of-devops-journey-ecomme.gitbook.io/50-days-of-devops-ecommerce-microservices)

Tracking of this project progress at [JIRA](https://devops-learning-journey.atlassian.net/jira/software/projects/ECMP/summary)

# E-commerce Microservices Platform

A DevOps project to build a scalable e-commerce application using microservices, targeting AWS deployment.

## Overview
This project implements four microservices to simulate an e-commerce platform:
- **User Service**: Manages user data (Java, Spring Boot).
- **Product Service**: Handles product catalog (Node.js, Express).
- **Order Service**: Processes orders by calling User and Product (Python, Flask).
- **Recommend Service**: Suggests products by calling Product (Go).

## Architecture
- **Microservices**: REST APIs running locally on ports 8080 (User), 3000 (Product), 5000 (Order), 8081 (Recommend).
- **Communication**: Services interact via HTTP GET requests.
- **Error Handling**: Graceful failures for unavailable services.
- **Future**: Docker, Kubernetes, CI/CD, monitoring on AWS Free Tier.

## Setup and Running Locally
1. **Clone the Repo**:
```bash
   git clone https://github.com/charan-happy/Ecommerce-Microservices-DevOps-project.git
   cd Ecommerce-Microservices-DevOps-project
```

2. **Install Dependencies**:
- User: cd user-service && mvn package
- Product: cd product-service && npm install
- Order: cd order-service && pip3 install -r requirements.txt
- Recommend: cd recommend-service && go mod tidy

3. **Run Services (in separate terminal)**:
- User: java -jar target/user-service-1.0-SNAPSHOT.jar
- Product: node app.js
- Order: python3 app.py
- Recommend: go run main.go

4. **Test Endpoints**:
- curl http://localhost:8080/users
- curl http://localhost:3000/products
- curl http://localhost:5000/orders
- curl http://localhost:8081/recommend

- curl -X POST -H "Content-Type: application/json" -d '{"user_id": 1, "product_id": 101}'


## User Interface
- **User Management**: Visit `http://localhost:8080/` to add, update, or delete users.
- **Product Management**: Visit `http://localhost:3000/` to add or delete products.

## API Endpoints
- **User Service**:
  - `GET /users`: List all users.
  - `GET /users/{id}`: Get user by ID.
  - `POST /users`: Create user (`{"name": "Alice"}`).
  - `PUT /users/{id}`: Update user.
  - `DELETE /users/{id}`: Delete user.
- **Product Service**:
  - `GET /products`: List all products.
  - `GET /products/{id}`: Get product by ID.
  - `POST /products`: Create product (`{"name": "Phone", "price": 499}`).
  - `PUT /products/{id}`: Update product.
  - `DELETE /products/{id}`: Delete product.
- **Order Service**:
  - `POST /orders`: Create order (`{"user_id": 1, "product_id": 101}`).
- **Recommend Service**:
  - `GET /recommend`: Get recommended product.
