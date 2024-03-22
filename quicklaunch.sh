#!/bin/bash

run_backend() {
    echo "Building and running backend service..."
    cd api
    sudo docker build -t mhib/tlcbackend .
    sudo docker rm -f tlc-backend
    sudo docker run -d --name tlc-backend -p 80:80 mhib/tlcbackend
    cd ..
}

run_frontend() {
    echo "Building and running frontend service..."
    cd front
    sudo docker build -t mhib/tlcfrontend .
    sudo docker rm -f tlc-frontend
    sudo docker run -d --name tlc-frontend -p 80:80 mhib/tlcfrontend
    cd ..
}

if [ "$1" = "backend" ]; then
    run_backend
fi

if [ "$1" = "front" ]; then
    run_frontend
fi

if [ "$1" = "backend" ] && [ "$2" = "front" ]; then
    run_backend
    run_frontend
fi

sudo docker-compose up -d