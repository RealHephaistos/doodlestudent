# Projet TLC

## Auteurs:
- **BERROUCHE Issameddine**
- **HAMONO Morvan**

## Lancement du projet:
* Cloner le projet
* Placer vous dans le dossier du api
* Lancer les commandes suivantes:
    - `docker build -t mhib/tlcbackend .`
    - `docker run -d --name tlc-backend mhib/tlcbackend`

- Placer vous dans le dossier du front
- Lancer les commandes suivantes:
    - `docker build -t mhib/tlcfrontend .`
    - `docker run -d --name tlc-frontend -p 80:80 mhib/tlcfrontend`