#!/bin/bash
# Script de lancement rapide pour le projet TLC

clean() {
    echo "Cleaning up..."
    # Retire les containers
    sudo docker-compose down

    # Retire les images
    sudo docker rmi mhib/tlcfrontend:latest -f
    sudo docker rmi mhib/tlcbackend:latest -f
    sudo rm api/backend.tar
    sudo rm front/frontend.tar
    echo ""
}

build_backend() {
    echo "Building backend image and saving it as .tar..."
    cd api
    sudo docker build -f Dockerfile -t mhib/tlcbackend .
    sudo docker save -o backend.tar mhib/tlcbackend
    echo ""
    cd ..
}

build_frontend() {
    echo "Building backend image and saving it as .tar..."
    cd front
    sudo docker build -f Dockerfile -t mhib/tlcfrontend .
    sudo docker save -o frontend.tar mhib/tlcfrontend
    echo ""
    cd ..
}

load_images() {
    echo "Loading and tagging images..."
    sudo docker load -i api/backend.tar
    sudo docker load -i front/frontend.tar
    sudo docker tag mhib/tlcbackend mhib/tlcbackend:latest
    sudo docker tag mhib/tlcfrontend mhib/tlcfrontend:latest
    echo ""
}

compose() {
    echo "Running docker-compose..."
    sudo docker-compose up -d
    echo ""
}

show_help() {
    echo "Usage: quicklaunch.sh [OPTION]"
    echo "Options:"
    echo "-h, --help: Display this help message"
    echo "-c, --clean: Clean up docker containers and images"
    echo "-b, --backend: Build and save the backend image"
    echo "-f, --front: Build and save the frontend image"
    echo "-l, --load: Load images to Docker registry"
    echo "-d, --docker-compose: Run docker-compose"
    echo "-a, --all: Clean, build and run all services"
    echo ""
}

if(( $# == 0 )); then
    show_help
    exit 1
fi

for i in "$@"
do
    case $i in
        -h|--help)
            show_help
            shift
        ;;
        -c|--clean)
            clean
            shift
        ;;
        -b|--backend)
            build_backend
            shift
        ;;
        -f|--front)
            build_frontend
            shift
        ;;
        -l|--load)
            load_images
            shift
        ;;
        -d|--docker-compose)
            compose
            shift
        ;;
        -a | --all)
            clean
            build_backend
            build_frontend
            load_images
            compose
            shift
        ;;
        *)
        ;;
    esac
done