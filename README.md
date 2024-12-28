# main


### 18_E_LEARN

Run:

```sh
docker compose --profile sql-only up -d
docker buildx create --name web-builder --driver docker-container --driver-opt network=18_e_learn_private-network --use
docker buildx build --builder web-builder -f Dockerfile .
docker compose --profile full up -d
```
use profile: `sql-only`, `full`, `web-only`

### Development

Connect to MSSQL [this file **DefaultConnection** string](./18_E_LEARN/18_E_LEARN.Web/appsettings.json):

```bash 
host.docker.internal (Windows) or 172.20.0.10 (linux)
```

In the default configuration, the web and SQL services are located in a private network, which prevents external access to MSSQL. Keep this in mind. To enable access for local development, edit the docker-compose file to expose MSSQL: `bridge-network:`.