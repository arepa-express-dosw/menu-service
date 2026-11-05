# menu-service

Arepa Express menu microservice. Spring Boot 3.5, Java 21, Maven.

## Endpoints

| Method | Path | Description |
|---|---|---|
| GET | `/menu` | Returns the arepa menu |
| GET | `/v3/api-docs` | OpenAPI document |
| GET | `/swagger-ui.html` | Swagger UI |

## Run locally

```bash
mvn spring-boot:run
curl http://localhost:8080/menu
```

## Build and container

```bash
mvn package
docker build -t menu-service .
```

The container listens on port 8080 and is deployed to Azure Container Apps as `menu-service`,
behind the API Management gateway (`/menu-api/menu`).
