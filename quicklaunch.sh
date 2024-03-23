#!/bin/bash

run_backend() {
    echo "Building and running backend service..."
    cd api
    sudo docker build -t mhib/tlcbackend .
    cd ..
}

run_frontend() {
    echo "Building and running frontend service..."
    cd front
    sudo docker build -t mhib/tlcfrontend .
    cd ..
}

clean() {
    echo "Cleaning up..."
    sudo docker-compose down

    sudo docker rmi mhib/tlcfrontend -f
    sudo docker rmi mhib/tlcbackend -f

    sudo sed -i '/# TLC/d' /etc/hosts
    sudo sed -i '/mhib.myadmin.tlc.fr/d' /etc/hosts
    sudo sed -i '/mhib.doodle.tlc.fr/d' /etc/hosts
    sudo sed -i '/mhib.pad.tlc.fr/d' /etc/hosts
    sudo sed -i '/api/d' /etc/hosts
    sudo sed -i '/myadmin/d' /etc/hosts
    sudo sed -i '/etherpad/d' /etc/hosts

    sudo rm /etc/nginx/sites-enabled/tlc
    sudo service nginx restart
}

compose() {
    echo "Running docker-compose..."
    sudo docker-compose up -d
}

config_dns() {
    echo "Configuring DNS..."
    sudo echo "# TLC" >> /etc/hosts
    sudo echo "127.0.0.1 mhib.myadmin.tlc.fr" >> /etc/hosts
    sudo echo "127.0.0.1 mhib.doodle.tlc.fr" >> /etc/hosts
    sudo echo "127.0.0.1 mhib.pad.tlc.fr" >> /etc/hosts
    sudo echo "127.0.0.1 api" >> /etc/hosts
    sudo echo "127.0.0.1 myadmin" >> /etc/hosts
    sudo echo "127.0.0.1 etherpad" >> /etc/hosts
}

set_nginx_config(){
    echo "Setting up nginx configuration..."
    sudo cp nginx.conf /etc/nginx/sites-available/tlc
    sudo ln -s /etc/nginx/sites-available/tlc /etc/nginx/sites-enabled/
    sudo service nginx restart
}

show_help() {
    echo "Usage: quicklaunch.sh [OPTION]"
    echo "Options:"
    echo "-h, --help: Display this help message"
    echo "-c, --clean: Clean up docker containers and images"
    echo "-b, --backend: Build and run the backend service"
    echo "-f, --front: Build and run the frontend service"
    echo "-d, --docker-compose: Run docker-compose"
    echo "-C, --config-dns: Configure DNS"
    echo "-n, --nginx: Set up nginx configuration"
    echo "-a, --all: Clean, build and run all services"
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
    run_backend
    shift
    ;;
    -f|--front)
    run_frontend
    shift
    ;;
    -d|--docker-compose)
    compose
    shift
    ;;
    -C|--config-dns)
    config_dns
    shift
    ;;
    -n|--nginx)
    set_nginx_config
    shift
    ;;
    -a | --all)
    clean
    config_dns
    run_backend
    run_frontend
    compose
    set_nginx_config
    shift
    ;;
    *)
    ;;
esac
done