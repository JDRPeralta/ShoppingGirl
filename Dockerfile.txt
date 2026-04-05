# Etapa 1: Construir el proyecto con Maven y Java 17
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Etapa 2: Crear el servidor Tomcat 10 y poner tu página adentro
FROM tomcat:10.1-jdk17
COPY --from=build /app/target/LibreriaViva-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
