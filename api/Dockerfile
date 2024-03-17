# Build du back-end de l'application
FROM maven:3.8.1-jdk-11 as backend-build
WORKDIR /app

# Installation des dépendances et construction de l'application
COPY . ./api
RUN cd api &&\
    mvn clean package -DskipTests

# Construction des images docker
FROM nginx:alpine

# Back-end
COPY --from=backend-build /app/api/target/tlcapi-0.0.1-SNAPSHOT.jar /app.jar