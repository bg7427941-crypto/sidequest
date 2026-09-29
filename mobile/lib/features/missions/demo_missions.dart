import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

/// Puntos públicos de referencia para el modo demo de SideQuest.
/// Las misiones son ficticias y no implican recomendación, disponibilidad
/// ni verificación de condiciones, horarios o seguridad del lugar.
class DemoMission {
  const DemoMission({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.xp,
    required this.location,
    required this.locationName,
    required this.icon,
    required this.radiusMeters,
  });

  final String id;
  final String title;
  final String description;
  final String category;
  final String difficulty;
  final String locationName;
  final int xp;
  final int radiusMeters;
  final LatLng location;
  final IconData icon;
}

const demoMissions = <DemoMission>[
  DemoMission(
    id: 'plaza-mayor',
    title: 'El corazón de Lima',
    description: 'Explora los alrededores de la Plaza Mayor y observa su arquitectura. Misión de demostración.',
    category: 'Exploración', difficulty: 'Fácil', xp: 50,
    location: LatLng(-12.0453, -77.0308), locationName: 'Plaza Mayor de Lima',
    icon: Icons.explore, radiusMeters: 180,
  ),
  DemoMission(
    id: 'parque-reserva',
    title: 'Una pausa verde',
    description: 'Descubre los espacios públicos del Parque de la Reserva. Verifica horarios y accesos antes de ir.',
    category: 'Naturaleza', difficulty: 'Media', xp: 80,
    location: LatLng(-12.0706, -77.0333), locationName: 'Parque de la Reserva',
    icon: Icons.park, radiusMeters: 220,
  ),
  DemoMission(
    id: 'parque-kennedy',
    title: 'Detalles de Miraflores',
    description: 'Observa un detalle del paisaje urbano en el entorno del Parque Kennedy. Misión de demostración.',
    category: 'Fotografía', difficulty: 'Fácil', xp: 60,
    location: LatLng(-12.1211, -77.0297), locationName: 'Parque Kennedy',
    icon: Icons.photo_camera, radiusMeters: 180,
  ),
  DemoMission(
    id: 'barranco',
    title: 'Arquitectura de Barranco',
    description: 'Pasea por el entorno público del Puente de los Suspiros y observa su arquitectura.',
    category: 'Cultura e historia', difficulty: 'Media', xp: 90,
    location: LatLng(-12.1493, -77.0222), locationName: 'Puente de los Suspiros',
    icon: Icons.account_balance, radiusMeters: 160,
  ),
  DemoMission(
    id: 'parque-de-la-amistad',
    title: 'Puerta de Santiago',
    description: 'Explora el entorno del Parque de la Amistad y busca detalles arquitectónicos.',
    category: 'Arquitectura', difficulty: 'Fácil', xp: 60,
    location: LatLng(-12.1117, -76.9958), locationName: 'Parque de la Amistad',
    icon: Icons.architecture, radiusMeters: 220,
  ),
  DemoMission(
    id: 'huaca-pucllana',
    title: 'Ciudad antes de la ciudad',
    description: 'Observa la presencia de la Huaca Pucllana dentro del paisaje urbano de Miraflores.',
    category: 'Cultura e historia', difficulty: 'Media', xp: 90,
    location: LatLng(-12.1107, -77.0359), locationName: 'Huaca Pucllana',
    icon: Icons.account_balance, radiusMeters: 220,
  ),
  DemoMission(
    id: 'malecón-miraflores',
    title: 'Horizonte del Pacífico',
    description: 'Recorre un tramo del malecón y observa cómo cambia el paisaje entre ciudad y costa.',
    category: 'Fotografía', difficulty: 'Fácil', xp: 70,
    location: LatLng(-12.1322, -77.0318), locationName: 'Malecón de Miraflores',
    icon: Icons.photo_camera, radiusMeters: 260,
  ),
  DemoMission(
    id: 'parque-del-amor',
    title: 'Una vista diferente',
    description: 'Busca un detalle artístico en el entorno del Parque del Amor y registra tu descubrimiento.',
    category: 'Arte', difficulty: 'Fácil', xp: 60,
    location: LatLng(-12.1342, -77.0312), locationName: 'Parque del Amor',
    icon: Icons.palette, radiusMeters: 180,
  ),
  DemoMission(
    id: 'larcomar',
    title: 'Ciudad frente al mar',
    description: 'Observa cómo el espacio urbano se integra con el acantilado y el litoral.',
    category: 'Arquitectura', difficulty: 'Fácil', xp: 50,
    location: LatLng(-12.1338, -77.0292), locationName: 'Entorno de Larcomar',
    icon: Icons.location_city, radiusMeters: 220,
  ),
  DemoMission(
    id: 'puente-de-los-suspiros',
    title: 'Cruza el tiempo',
    description: 'Observa los detalles del entorno del puente y su relación con las calles de Barranco.',
    category: 'Cultura e historia', difficulty: 'Fácil', xp: 70,
    location: LatLng(-12.1496, -77.0220), locationName: 'Puente de los Suspiros',
    icon: Icons.emoji_objects, radiusMeters: 140,
  ),
  DemoMission(
    id: 'bajada-de-banos',
    title: 'Camino al acantilado',
    description: 'Explora visualmente la Bajada de Baños y encuentra un detalle que cuente algo del barrio.',
    category: 'Exploración', difficulty: 'Media', xp: 80,
    location: LatLng(-12.1506, -77.0221), locationName: 'Bajada de Baños',
    icon: Icons.directions_walk, radiusMeters: 180,
  ),
  DemoMission(
    id: 'parque-reducto',
    title: 'Memoria urbana',
    description: 'Recorre el entorno del parque y observa elementos que conectan espacio público e historia.',
    category: 'Cultura e historia', difficulty: 'Media', xp: 80,
    location: LatLng(-12.1169, -77.0270), locationName: 'Parque Reducto Nº 2',
    icon: Icons.history_edu, radiusMeters: 220,
  ),
  DemoMission(
    id: 'parque-el-olivar',
    title: 'Entre olivos',
    description: 'Explora el paisaje del parque y busca un detalle natural que normalmente pase desapercibido.',
    category: 'Naturaleza', difficulty: 'Fácil', xp: 70,
    location: LatLng(-12.1027, -77.0370), locationName: 'Bosque El Olivar',
    icon: Icons.nature_people, radiusMeters: 260,
  ),
  DemoMission(
    id: 'parque-mariscal-castilla',
    title: 'Rincones de Lince',
    description: 'Explora el espacio público y encuentra un punto interesante para fotografiar.',
    category: 'Fotografía', difficulty: 'Fácil', xp: 50,
    location: LatLng(-12.0882, -77.0360), locationName: 'Parque Mariscal Castilla',
    icon: Icons.camera_alt, radiusMeters: 220,
  ),
  DemoMission(
    id: 'campo-de-marte',
    title: 'Gran espacio urbano',
    description: 'Observa cómo un gran espacio abierto funciona dentro de una zona densamente urbana.',
    category: 'Exploración', difficulty: 'Fácil', xp: 60,
    location: LatLng(-12.0750, -77.0480), locationName: 'Campo de Marte',
    icon: Icons.directions_run, radiusMeters: 300,
  ),
  DemoMission(
    id: 'plaza-san-martin',
    title: 'Geometría de una plaza',
    description: 'Observa la composición urbana de la plaza y sus edificios alrededor.',
    category: 'Arquitectura', difficulty: 'Media', xp: 80,
    location: LatLng(-12.0520, -77.0360), locationName: 'Plaza San Martín',
    icon: Icons.location_city, radiusMeters: 180,
  ),
  DemoMission(
    id: 'parque-de-la-exposicion',
    title: 'Arte al aire libre',
    description: 'Explora el entorno del Parque de la Exposición y localiza un elemento artístico.',
    category: 'Arte', difficulty: 'Fácil', xp: 70,
    location: LatLng(-12.0582, -77.0322), locationName: 'Parque de la Exposición',
    icon: Icons.palette, radiusMeters: 230,
  ),
  DemoMission(
    id: 'museo-de-arte-de-lima',
    title: 'Una fachada para recordar',
    description: 'Observa la arquitectura exterior del entorno del museo y sus detalles.',
    category: 'Arte', difficulty: 'Media', xp: 80,
    location: LatLng(-12.0592, -77.0325), locationName: 'Museo de Arte de Lima',
    icon: Icons.museum, radiusMeters: 180,
  ),
  DemoMission(
    id: 'congreso',
    title: 'Escena republicana',
    description: 'Observa la arquitectura del entorno del Congreso desde espacios públicos permitidos.',
    category: 'Arquitectura', difficulty: 'Media', xp: 80,
    location: LatLng(-12.0439, -77.0288), locationName: 'Entorno del Congreso',
    icon: Icons.account_balance, radiusMeters: 220,
  ),
  DemoMission(
    id: 'plaza-bolognesi',
    title: 'Una plaza histórica',
    description: 'Explora la composición de la Plaza Bolognesi y sus edificios circundantes.',
    category: 'Cultura e historia', difficulty: 'Fácil', xp: 60,
    location: LatLng(-12.0564, -77.0420), locationName: 'Plaza Bolognesi',
    icon: Icons.history, radiusMeters: 180,
  ),
  DemoMission(
    id: 'parque-de-las-leyendas',
    title: 'Ruta de naturaleza',
    description: 'Descubre el entorno del parque y observa cómo conviven naturaleza, cultura y ciudad.',
    category: 'Naturaleza', difficulty: 'Media', xp: 90,
    location: LatLng(-12.0474, -77.0920), locationName: 'Parque de las Leyendas',
    icon: Icons.forest, radiusMeters: 350,
  ),
  DemoMission(
    id: 'malecon-de-san-miguel',
    title: 'Atardecer costero',
    description: 'Busca una composición interesante entre cielo, mar y ciudad en el malecón.',
    category: 'Fotografía', difficulty: 'Fácil', xp: 70,
    location: LatLng(-12.0908, -77.0955), locationName: 'Malecón de San Miguel',
    icon: Icons.wb_sunny, radiusMeters: 280,
  ),
  DemoMission(
    id: 'puente-de-la-amistad',
    title: 'Conecta los caminos',
    description: 'Explora un punto de conexión urbana y observa el movimiento del entorno.',
    category: 'Exploración', difficulty: 'Fácil', xp: 50,
    location: LatLng(-12.1125, -76.9960), locationName: 'Entorno de Surco',
    icon: Icons.alt_route, radiusMeters: 200,
  ),
];

List<String> get demoCategories => demoMissions.map((m) => m.category).toSet().toList()..sort();

List<String> get demoDifficulties => demoMissions.map((m) => m.difficulty).toSet().toList()..sort();
