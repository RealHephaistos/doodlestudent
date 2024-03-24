# Build du back-end de l'application
FROM openjdk as backend-build
WORKDIR /app

# Installation des dépendances et construction de l'application
COPY . ./api
RUN cd api &&\
    ./mvnw clean package -Dquarkus.package.type=uber-jar

# Construction de l'images docker back-end
FROM openjdk
COPY --from=backend-build /app/api/target/tlcdemoApp-1.0.0-SNAPSHOT-runner.jar /app/

# Variables d'environnement pour la configuration de l'application
ENV quarkus_datasource_jdbc_url "jdbc:mysql://db:3306/tlc?useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false&useLegacyDatetimeCode=false&createDatabaseIfNotExist=true&serverTimezone=Europe/Paris"
ENV quarkus_datasource_username tlc
ENV quarkus_datasource_password tlc
ENV quarkus_hibernate_orm_database_generation update
ENV quarkus_mailer_from olivier.barais@gmail.com
ENV quarkus_mailer_host localhost
ENV quarkus_mailer_port 2525
ENV quarkus_mailer_ssl false
ENV quarkus_mailer_username "user"
ENV quarkus_mailer_password "admin"
ENV quarkus_mailer_mock true
ENV doodle_usepad false
ENV doodle_padUrl http://etherpad:9001/
ENV doodle_padApiKey "changeit"
ENV doodle_organizermail "issameddine.berrouche@gmail.com"

CMD ["java", "-jar", "/app/tlcdemoApp-1.0.0-SNAPSHOT-runner.jar"]