# SideQuest API

API FastAPI para el catálogo de misiones geolocalizadas de SideQuest.

## Endpoints

- `GET /health`
- `GET /api/v1/missions`
- `GET /api/v1/missions?category=Arte`
- `GET /api/v1/missions?difficulty=Media`
- `GET /api/v1/missions/{mission_id}`
- `GET /api/v1/missions/nearby?latitude=-12.12&longitude=-77.03&radius_km=10`
- `POST /api/v1/missions`
- Documentación interactiva: `/docs`

## Geodatos

Las misiones se almacenan como `POINT` WGS84 (`SRID 4326`) mediante PostGIS. El endpoint `nearby` usa `ST_DWithin` y calcula la distancia sobre `geography`, por lo que la consulta está preparada para búsquedas por radio en metros.

## Desarrollo local

Con Docker Compose:

```bash
docker compose up --build
```

La API queda en `http://localhost:8000` y Swagger en `http://localhost:8000/docs`.

El seed contiene las misiones de demostración del mapa móvil. Son datos de demostración; horarios, accesos y condiciones reales deben verificarse antes de visitar un lugar.
