FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
COPY data ./data
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/credit-risk-system-0.0.1-SNAPSHOT.jar app.jar
COPY --from=build /app/data ./data
EXPOSE 8085
ENTRYPOINT ["java", "-jar", "app.jar"]