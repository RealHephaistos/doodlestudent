# Build du back-end de l'application
FROM maven:3.6.3 as backend-build
WORKDIR /app

# Installation des dépendances et construction de l'application
COPY . ./api
RUN cd api &&\
    mvn clean package -Dquarkus.package.type=uber-jar

# Construction de l'images docker back-end
FROM openjdk
COPY --from=backend-build /app/api/target/tlcdemoApp-1.0.0-SNAPSHOT-runner.jar /app/
CMD ["java", "-jar", "/app/tlcdemoApp-1.0.0-SNAPSHOT-runner.jar"]