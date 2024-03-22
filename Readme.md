# Projet TLC

## Auteurs

- **BERROUCHE Issameddine**
- **HAMONO Morvan**

## Lancement du projet en local manuellement

### Générer les images docker

- Clonez le projet
- Placez-vous à la racine du projet
- Exécutez la commande suivante pour générer les images docker : ```sudo bash quicklaunch.sh```
Le script peut prendre 3 arguments :
  - ```-c``` ou ```--clean```  pour supprimer les images docker existantes avant de les recréer
  - ```-b``` ou ```--backend``` pour ne générer que l'image du backend
  - ```-f``` ou ```--frontend``` pour ne générer que l'image du frontend

Vous devriez avoir accès à l'application sur le port 80 de votre machine.
