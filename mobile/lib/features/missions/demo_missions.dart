import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

/// Coordenadas de espacios públicos de referencia; misiones ficticias de demostración.
/// No constituyen una recomendación de seguridad ni verifican condiciones del lugar.
class DemoMission {
  const DemoMission({required this.id, required this.title, required this.description,
    required this.category, required this.difficulty, required this.xp,
    required this.location, required this.locationName, required this.icon, required this.radiusMeters});
  final String id, title, description, category, difficulty, locationName;
  final int xp;
  final int radiusMeters;
  final LatLng location;
  final IconData icon;
}

const demoMissions = <DemoMission>[
  DemoMission(id: 'plaza-mayor', title: 'El corazón de Lima', description: 'Explora los alrededores de la Plaza Mayor y observa su arquitectura. Misión de demostración.', category: 'Exploración', difficulty: 'Fácil', xp: 50, location: LatLng(-12.0453, -77.0308), locationName: 'Plaza Mayor de Lima', icon: Icons.explore, radiusMeters: 180),
  DemoMission(id: 'parque-reserva', title: 'Una pausa verde', description: 'Descubre los espacios públicos del Parque de la Reserva. Misión de demostración: verifica horarios y accesos antes de ir.', category: 'Naturaleza', difficulty: 'Media', xp: 80, location: LatLng(-12.0706, -77.0333), locationName: 'Parque de la Reserva', icon: Icons.park, radiusMeters: 220),
  DemoMission(id: 'parque-kennedy', title: 'Detalles de Miraflores', description: 'Observa un detalle del paisaje urbano en el entorno del Parque Kennedy. Misión de demostración.', category: 'Fotografía', difficulty: 'Fácil', xp: 60, location: LatLng(-12.1211, -77.0297), locationName: 'Parque Kennedy', icon: Icons.photo_camera, radiusMeters: 180),
  DemoMission(id: 'barranco', title: 'Arquitectura de Barranco', description: 'Pasea por el entorno público del Puente de los Suspiros y observa su arquitectura. Misión de demostración.', category: 'Cultura e historia', difficulty: 'Media', xp: 90, location: LatLng(-12.1493, -77.0222), locationName: 'Puente de los Suspiros', icon: Icons.account_balance, radiusMeters: 160),
];
