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

    # Retire les configurations nginx
    echo "Removing nginx configuration..."
    sudo rm -rf /etc/nginx/sites-enabled/tlc
    sudo rm -rf /etc/nginx/sites-available/tlc
    sudo service nginx restart
    echo ""
}

build_backend() {
    echo "Building backend image and saving it as .tar..."
    cd api
    sudo docker build -t mhib/tlcbackend .
    sudo docker save -o backend.tar mhib/tlcbackend
    echo ""
    cd ..
}

build_frontend() {
    echo "Building backend image and saving it as .tar..."
    cd front
    sudo docker build -t mhib/tlcfrontend .
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

set_nginx_config(){
    echo "Setting up nginx configuration..."
    sudo cp nginx.conf /etc/nginx/sites-available/tlc
    sudo ln -s /etc/nginx/sites-available/tlc /etc/nginx/sites-enabled/
    sudo service nginx restart
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
    echo "-n, --nginx: Set up nginx configuration"
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
        -n|--nginx)
            set_nginx_config
            shift
        ;;
        -a | --all)
            clean
            build_backend
            build_frontend
            load_images
            compose
            set_nginx_config
            shift
        ;;
        *)
        ;;
    esac
done