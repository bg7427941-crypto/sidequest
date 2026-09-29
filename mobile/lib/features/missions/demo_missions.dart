import 'package:flutter/material.dart';

/// DEMO DATA ONLY: not verified places. Replaced by the API in phase 3.
class DemoMission {
  const DemoMission({
    required this.title,
    required this.category,
    required this.difficulty,
    required this.xp,
    required this.distanceKm,
    required this.icon,
  });

  final String title;
  final String category;
  final String difficulty;
  final int xp;
  final double distanceKm;
  final IconData icon;
}

const demoMissions = <DemoMission>[
  DemoMission(title: 'Descubre los alrededores de una plaza', category: 'Exploración', difficulty: 'Fácil', xp: 50, distanceKm: 0.6, icon: Icons.explore),
  DemoMission(title: 'Fotografía un mural urbano', category: 'Fotografía', difficulty: 'Fácil', xp: 60, distanceKm: 1.2, icon: Icons.photo_camera),
  DemoMission(title: 'Encuentra un detalle arquitectónico', category: 'Cultura e historia', difficulty: 'Media', xp: 90, distanceKm: 2.1, icon: Icons.account_balance),
  DemoMission(title: 'Registra un descubrimiento en un parque', category: 'Naturaleza', difficulty: 'Media', xp: 80, distanceKm: 3.4, icon: Icons.park),
];
