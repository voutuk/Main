# OLX_Dyplom
Publish with Docker-Compose

1. `docker compose --profile full build` - спочатку збілдить

`docker compose --profile back up -d` - піднімається тільки бекенд

`docker compose --profile front up -d` - піднімається тільки фронт

2. `docker compose --profile full up -d` - повністю піднімається


## Білд імеджів для прода 

`docker compose --profile prod build` - білд

## Ресурси на використання