# SideQuest — Fase 5: persistencia y gamificación

## Implementado

- Persistencia local del progreso mediante `shared_preferences`.
- Recuperación automática de XP y estados de misión al abrir la aplicación.
- Reinicio manual del progreso de demo desde Perfil.
- Sistema de insignias basado en progreso real.
- Perfil ampliado con nivel, XP, estadísticas, insignias e historial.
- Tests unitarios para progresión, recompensas únicas y desbloqueo de insignias.

## Persistencia

El estado local se guarda como JSON bajo la clave `sidequest_player_state_v1`.

Se persisten:

- XP total.
- Misiones iniciadas.
- Misiones completadas.

No se almacenan coordenadas del usuario ni se implementa seguimiento de ubicación en segundo plano.

## Insignias actuales

| Insignia | Requisito |
|---|---|
| Primera aventura | Completar 1 misión |
| Explorador urbano | Completar 3 misiones |
| Veterano | Alcanzar 300 XP |
| Explorador completo | Completar misiones de 3 categorías |
| Rango superior | Alcanzar nivel 5 |

## Siguiente fase

La siguiente etapa prevista es sustituir el almacenamiento local por una API con FastAPI y PostgreSQL/PostGIS, manteniendo el estado y las reglas de dominio separados de la interfaz móvil.
