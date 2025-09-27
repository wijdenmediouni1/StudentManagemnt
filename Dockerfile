FROM maven:3.9.2-eclipse-temurin-17 AS build
WORKDIR /app

# Copier pom.xml et src/ avant de build
COPY pom.xml .
COPY src ./src

# Build le projet
RUN mvn clean install -DskipTests

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
