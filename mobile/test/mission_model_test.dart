import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sidequest/features/missions/demo_missions.dart';

void main() {
  test('convierte una misión de API al modelo del mapa', () {
    final mission = DemoMission.fromJson({
      'id': 'demo-api',
      'title': 'Misión API',
      'description': 'Prueba',
      'category': 'Arte',
      'difficulty': 'Media',
      'xp': 80,
      'location_name': 'Punto demo',
      'latitude': -12.1,
      'longitude': -77.03,
      'radius_meters': 200,
    });

    expect(mission.id, 'demo-api');
    expect(mission.xp, 80);
    expect(mission.location.latitude, -12.1);
    expect(mission.location.longitude, -77.03);
    expect(mission.icon, Icons.palette);
  });
}
