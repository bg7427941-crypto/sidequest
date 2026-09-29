# sidequest

Un nuevo proyecto de Flutter.

## Comenzar

Este proyecto es un punto de partida para una aplicación de Flutter.

Aquí hay algunos recursos para empezar si es tu primer proyecto de Flutter:

- [Aprende Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Escribe tu primera aplicación de Flutter](https://docs.flutter.dev/get-started/codelab)
- [Recursos de aprendizaje de Flutter](https://docs.flutter.dev/reference/learning-resources)

Para obtener ayuda para comenzar con el desarrollo de Flutter, consulta la
[documentación en línea](https://docs.flutter.dev/), que ofrece tutoriales,
ejemplos, orientación sobre desarrollo móvil y una referencia completa de API.

## Backend — Fase 6

El proyecto incluye una API FastAPI con PostgreSQL/PostGIS en `../backend` y un `docker-compose.yml` en la raíz.

### Levantar API + PostGIS

```bash
docker compose up --build
```

- API: `http://localhost:8000`
- Swagger: `http://localhost:8000/docs`
- Health: `http://localhost:8000/health`

En Android Emulator, Flutter usa por defecto `http://10.0.2.2:8000`, que apunta al host del emulador. Para otra dirección puedes compilar con:

```bash
flutter run --dart-define=SIDEQUEST_API_URL=http://TU_IP:8000
```

La app conserva un fallback local: si la API no responde, continúa mostrando las misiones demo.
