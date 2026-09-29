# Ejecutar SideQuest (Fase 1)

1. Instala Flutter (canal stable) y Android Studio con un emulador, o activa depuración USB en tu teléfono.
2. Desde `sidequest/mobile` genera la carpeta de plataforma (no incluida aquí):
   `flutter create . --org com.sidequest --project-name sidequest --platforms android`
   (no sobrescribas `lib/`, `test/` ni `pubspec.yaml` si te pregunta).
3. `flutter pub get`
4. `flutter analyze` y `flutter test`
5. `flutter run`
6. APK (más adelante): `flutter build apk --release`
