import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/missions/demo_missions.dart';

/// Repository único para que la UI no dependa directamente de HTTP.
/// En Android Emulator, 10.0.2.2 apunta al host donde corre Docker.
class MissionRepository {
  MissionRepository({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  static const apiBaseUrl = String.fromEnvironment(
    'SIDEQUEST_API_URL',
    defaultValue: 'http://10.0.2.2:8000',
  );

  Future<List<DemoMission>> getMissions() async {
    try {
      final response = await _dio.get<List<dynamic>>(
        '$apiBaseUrl/api/v1/missions',
        options: Options(receiveTimeout: const Duration(seconds: 5)),
      );
      final data = response.data ?? const <dynamic>[];
      return data
          .whereType<Map<String, dynamic>>()
          .map(DemoMission.fromJson)
          .toList();
    } catch (_) {
      // El modo demo permite que la app siga funcionando sin backend.
      return demoMissions;
    }
  }

  Future<List<DemoMission>> getNearby({
    required double latitude,
    required double longitude,
    double radiusKm = 10,
  }) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        '$apiBaseUrl/api/v1/missions/nearby',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'radius_km': radiusKm,
        },
        options: Options(receiveTimeout: const Duration(seconds: 5)),
      );
      final data = response.data ?? const <dynamic>[];
      return data
          .whereType<Map<String, dynamic>>()
          .map(DemoMission.fromJson)
          .toList();
    } catch (_) {
      return demoMissions;
    }
  }
}

final missionRepositoryProvider = Provider<MissionRepository>(
  (ref) => MissionRepository(),
);

final missionsProvider = FutureProvider<List<DemoMission>>((ref) {
  return ref.watch(missionRepositoryProvider).getMissions();
});
