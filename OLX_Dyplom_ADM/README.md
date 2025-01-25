# OLX_Dyplom
Publish with Docker-Compose
```
apt  install docker-compose

docker-compose config
docker-compose pull
docker compose up -d

docker-compose down
docker-compose down --rmi all --volumes

chmod +x docker_actions.sh
./docker_actions.sh


docker build -t olx-client ./OLX.Frontend

docker build -t olx-asp-api ./OLX.API