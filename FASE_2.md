# SideQuest — Fase 2: exploración móvil

Esta versión modifica el proyecto Flutter existente. Incluye mapa táctil con teselas de OpenStreetMap, marcadores de cuatro misiones **ficticias** situadas en espacios públicos de Lima, filtros por categoría, dificultad y radio, permisos GPS bajo demanda, botón de ubicación y detalle de misión.

## Ejecutar

```bash
cd mobile
flutter pub get
flutter run
```

Para crear APK: `flutter build apk --debug` (necesitas Flutter y Android SDK instalados).

## Qué probar en Android

1. Abre Explorar y comprueba que carguen las teselas (necesita internet).
2. Toca cada marcador y abre el detalle.
3. Cambia categoría, dificultad y radio.
4. Toca el botón GPS: acepta, rechaza y prueba con ubicación desactivada.
5. Comprueba que Inicio, Explorar, Misiones y Perfil siguen funcionando.

## Notas

- La distancia se calcula en línea recta, no por calles.
- Las misiones son demostraciones, no están verificadas ni permiten ganar XP todavía.
- La vista usa `tile.openstreetmap.org` solo para desarrollo y pruebas ligeras; para publicar o escalar, elige un proveedor de teselas con SLA y cumple su política de uso y atribución.
- No se guarda ni transmite la ubicación del usuario; la consulta GPS se hace solo al pulsar el botón.
- No hay backend en esta fase. La fase 3 conectará la API y la fase 4 verificará misiones.
- No se ejecutó Flutter ni se generó APK en este entorno; valida con los comandos indicados.
