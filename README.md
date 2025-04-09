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
