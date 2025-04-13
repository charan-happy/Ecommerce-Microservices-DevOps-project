FROM openjdk:17-jdk-slim
WORKDIR /app
# copy maven build jar file
COPY /target/user-service-1.0-SNAPSHOT.jar app.jar
COPY src/main/resources/static/ /app/static/
# expose the app
EXPOSE 8080
# Run jar
ENTRYPOINT ["java", "-jar", "app.jar"]
