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