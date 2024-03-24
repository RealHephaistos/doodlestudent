# Clone du projet git
FROM alpine/git as clone
WORKDIR /app

RUN git clone https://github.com/RealHephaistos/doodlestudent &&\
    cd doodlestudent &&\
    rm -rf front # Suppression du front-end, inutile pour le build du back-end

# Build du back-end de l'application
FROM openjdk as backend-build
WORKDIR /app

# Installation des dépendances et construction de l'application
COPY --from=clone /app/doodlestudent/ /app/doodlestudent/
RUN cd doodlestudent/api &&\
    ./mvnw clean package -Dquarkus.package.type=uber-jar

# Construction de l'images docker back-end
FROM openjdk
COPY --from=backend-build /app/doodlestudent/api/target/tlcdemoApp-1.0.0-SNAPSHOT-runner.jar /app/
CMD ["java", "-jar", "/app/tlcdemoApp-1.0.0-SNAPSHOT-runner.jar"]