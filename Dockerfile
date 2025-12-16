# Use OpenJDK 17 slim image
FROM openjdk:17-slim

# Argument pour le JAR
ARG JAR_FILE=target/*.jar

# Copier le JAR dans le conteneur
COPY ${JAR_FILE} app.jar

# Point d'entrée
ENTRYPOINT ["java", "-jar", "/app.jar"]
