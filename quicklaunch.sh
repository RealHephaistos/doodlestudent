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
    sudo docker rmi mhib/tlcbackend
    sudo docker rmi mhib/tlcfrontend
}

for i in "$@"
do
case $i in
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
    *)
    ;;
esac
done

sudo docker-compose up -d