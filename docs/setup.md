# Ejecutar SideQuest (Fase 1)

1. Instala Flutter (canal stable) y Android Studio con un emulador, o activa depuración USB en tu teléfono.
2. Desde `sidequest/mobile` genera la carpeta de plataforma (no incluida aquí):
   `flutter create . --org com.sidequest --project-name sidequest --platforms android`
   (no sobrescribas `lib/`, `test/` ni `pubspec.yaml` si te pregunta).
3. `flutter pub get`
4. `flutter analyze` y `flutter test`
5. `flutter run`
6. APK (más adelante): `flutter build apk --release`

## Backend — Fase 6

Requisitos: Docker Desktop o Docker Engine con Compose.

Desde la raíz del proyecto:

```bash
docker compose up --build
```

API: `http://localhost:8000`

Swagger: `http://localhost:8000/docs`

Healthcheck: `http://localhost:8000/health`

### Integración Flutter

El repository móvil `mobile/lib/core/network/mission_repository.dart` consulta:

- `GET /api/v1/missions`
- `GET /api/v1/missions/nearby`

La URL por defecto para Android Emulator es `http://10.0.2.2:8000`. Puedes cambiarla con `--dart-define=SIDEQUEST_API_URL=...`.
