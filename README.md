# menu-service

Servicio encargado de exponer el catálogo y precios de las arepas en Arepa Express. Desarrollado con Spring Boot 3.5, Java 21 y Maven.

## Endpoints

| Método | Ruta | Descripción |
|---|---|---|
| GET | `/menu` | Lista de arepas con id, nombre y precio |
| GET | `/v3/api-docs` | Especificación OpenAPI 3.1 |
| GET | `/swagger-ui.html` | Interfaz interactiva Swagger UI |

## Ejecución local

```bash
mvn spring-boot:run
curl http://localhost:8080/menu
```

## Empaquetado y contenedor

```bash
mvn package
docker build -t menu-service .
```

El contenedor expone el puerto 8080 y se encuentra publicado en Azure Container Apps bajo el nombre `menu-service`, enrutado a través del API Gateway en `/menu-api/menu`.
