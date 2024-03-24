# Build du back-end de l'application
FROM openjdk as backend-build
WORKDIR /app

# Installation des dépendances et construction de l'application
COPY . ./api
RUN cd api &&\
    ./mvnw clean package -Dquarkus.package.type=uber-jar -Dquarkus.native.container-build=true

# Construction de l'images docker back-end
FROM openjdk
COPY --from=backend-build /app/api/target/tlcdemoApp-1.0.0-SNAPSHOT-runner.jar /app/
CMD ["java", "-jar", "/app/tlcdemoApp-1.0.0-SNAPSHOT-runner.jar"]