# main


### 18_E_LEARN

```sh
docker compose --profile sql-only up -d
docker compose --profile full up -d --build
docker compose --profile full up -d --no-build
```

Connect to MSSQL (Windows version):

```
host.docker.internal
```

Connect to MSSQL (Linux version):

```
10.10.10.201
```

```sh
docker buildx create --name web-builder --driver docker-container --driver-opt network=container:18_e_learn_app-network --use
docker buildx build --builder web-builder -f Dockerfile .
```