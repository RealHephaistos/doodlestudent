# Projet TLC

## Auteurs

- **BERROUCHE Issameddine**
- **HAMONO Morvan**

## Lancement du projet en local manuellement

### Générer les images docker

- Clonez le projet
- Placez vous dans le dossier "api"
- Lancez les commandes suivantes:
  - `sudo docker build -t mhib/tlcbackend .`
  - `sudo docker run -d --name tlc-backend -p 80:80 mhib/tlcbackend`

- Placez vous dans le dossier "front"
- Lancez les commandes suivantes:
  - `sudo docker build -t mhib/tlcfrontend .`
  - `sudo docker run -d --name tlc-frontend -p 80:80 mhib/tlcfrontend`

Vous devriez avoir accès à l'application sur le port 80 de votre machine.
