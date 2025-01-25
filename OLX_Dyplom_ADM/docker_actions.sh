#!/bin/bash


set -e

server_up() {
    echo "Server up..."
    docker-compose pull
    docker compose up -d
}

server_remove() {
    echo "Server remove..."
    docker-compose down --rmi all --volumes
}

start_containers() {
    echo "Conteiners start..."
    docker-compose up -d
}

stop_containers() {
    echo "Conteiners stop..."
    docker-compose down
}

restart_containers() {
    echo "Conteiners restart..."
    docker-compose down
    docker-compose up -d
}

view_logs() {
    echo "Logs..."
    docker-compose logs -f
}

# Меню для вибору дії
echo "Chouse action:"
echo "1. Server up"
echo "2. Server remove"
echo "3. Conteiners start"
echo "4. Conteiners stop"
echo "5. Conteiners restart"
echo "6. Logs"
read -p "Enter action number: " action

case $action in
    1)
        server_up
        ;;
    2)
        server_remove
        ;;
    3)
        start_containers
        ;;
    4)
        stop_containers
        ;;
    5)
        restart_containers
        ;;
    6)
        view_logs
        ;;
    *)
        echo "Invalid action number!"
        exit 1
        ;;
esac