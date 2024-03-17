# Build de la partie front-end de l'application
FROM node:lts-alpine3.19 as front-build
WORKDIR /app

# Installation des dépendances et construction de l'application
COPY . ./front
RUN cd front &&\
    npm install &&\
    npm run build

# Construction des images docker
FROM nginx:1.19.2-alpine
COPY --from=front-build /app/front/dist/tlcfront /usr/share/nginx/html
