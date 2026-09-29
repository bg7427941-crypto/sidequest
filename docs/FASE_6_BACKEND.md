# SideQuest — Fase 6: backend geoespacial

## Objetivo

Mover el catálogo de misiones fuera de Flutter y preparar una arquitectura cliente/API/BD que permita escalar de unas pocas misiones de demo a un catálogo mucho mayor.

## Implementado

- FastAPI como API REST.
- PostgreSQL con extensión PostGIS.
- Modelo `missions` con coordenadas `POINT` en WGS84.
- Índice espacial GiST.
- Listado y filtrado por categoría/dificultad.
- Detalle de misión por ID.
- Búsqueda de misiones cercanas por latitud, longitud y radio.
- Creación de misiones mediante API.
- Seed con las misiones del mapa expandido.
- Docker Compose para levantar API + PostGIS.
- Swagger/OpenAPI automático.

## Arquitectura

```text
Flutter
   │
   │ HTTP/JSON
   ▼
FastAPI
   │
   │ SQLAlchemy / GeoAlchemy2
   ▼
PostgreSQL + PostGIS
```

## Decisiones técnicas

La app móvil conserva por ahora el catálogo local para no romper el modo demo si la API no está disponible. La API ya tiene un contrato estable para la siguiente integración móvil.

El servidor debe ser la fuente de verdad para el catálogo y, más adelante, para validaciones de progreso y recompensas. Las claves de base de datos no deben distribuirse dentro de la aplicación Flutter.

## Siguiente paso: integración Flutter

1. Añadir `dio` al proyecto móvil.
2. Crear `MissionRepository` con implementación API y demo.
3. Cambiar Explore/Missions para consumir el repositorio.
4. Añadir estados de carga/error y cache local.
5. Añadir autenticación y sincronización del progreso.
6. Mover la validación de finalización al backend.
