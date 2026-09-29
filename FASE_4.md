# SideQuest — Fase 4: validación GPS

La app ahora permite iniciar una misión y verificarla mediante la ubicación actual del dispositivo.

## Flujo

1. El usuario abre una misión.
2. Pulsa **Iniciar misión**.
3. La app solicita el permiso de ubicación cuando intenta verificar.
4. Se obtiene una posición puntual con `geolocator`.
5. Se calcula la distancia en metros hasta el punto de la misión.
6. Solo si la distancia está dentro del `radiusMeters` configurado se concede el XP.
7. Una misión completada no puede volver a entregar XP.

## Radios demo

- Plaza Mayor: 180 m
- Parque de la Reserva: 220 m
- Parque Kennedy: 180 m
- Puente de los Suspiros: 160 m

Estos puntos y radios siguen siendo datos de demostración. Antes de producción conviene sustituirlos por datos administrados por backend y validar la finalización en servidor.

## Permisos

Android ya declara `ACCESS_FINE_LOCATION` y `ACCESS_COARSE_LOCATION`. No se usa ubicación en segundo plano: la app consulta la posición únicamente cuando el usuario pulsa **Verificar ubicación**.

## Próxima fase

Conectar FastAPI/PostgreSQL y mover al servidor la autoridad sobre misiones, radios, completados y recompensas para evitar que el cliente sea la fuente de verdad del XP.
