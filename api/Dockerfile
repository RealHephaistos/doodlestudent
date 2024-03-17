# Build du back-end de l'application
FROM maven as backend-build
WORKDIR /app

# Installation des dépendances et construction de l'application
COPY . ./api
RUN cd api &&\
    mvn clean package -DskipTests

# Construction de l'images docker back-end
FROM openjdk
COPY --from=backend-build /app/api/target/tlcdemoApp-1.0.0-SNAPSHOT.jar /app/
CMD ["java", "-jar", "/app/tlcdemoApp-1.0.0-SNAPSHOT.jar"]