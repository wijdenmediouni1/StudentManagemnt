# Étape 1 : Build
FROM maven:3.9.2-eclipse-temurin-17 AS build
WORKDIR /app

# Copier pom.xml et src/ ensemble
COPY pom.xml .
COPY src ./src

# Build le projet avec mvn clean install
RUN mvn clean install -DskipTests

# Étape 2 : Runtime
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copier le jar buildé depuis l'étape précédente
COPY --from=build /app/target/*.jar app.jar

# Exposer le port
EXPOSE 8080

# Lancer l'application
CMD ["java", "-jar", "app.jar"]

