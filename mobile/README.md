# sidequest

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

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
