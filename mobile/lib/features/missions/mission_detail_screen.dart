import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../core/player/player_state.dart';
import '../../core/theme/app_theme.dart';
import 'demo_missions.dart';

class MissionDetailScreen extends ConsumerStatefulWidget {
  const MissionDetailScreen({super.key, required this.mission});

  final DemoMission mission;

  @override
  ConsumerState<MissionDetailScreen> createState() => _MissionDetailScreenState();
}

class _MissionDetailScreenState extends ConsumerState<MissionDetailScreen> {
  bool _checkingLocation = false;
  double? _distanceMeters;
  String? _message;
  bool _isError = false;

  Future<void> _verifyLocation() async {
    if (_checkingLocation) return;
    setState(() {
      _checkingLocation = true;
      _message = null;
      _isError = false;
    });

    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw const _LocationException('Activa el GPS de tu teléfono e inténtalo de nuevo.');
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied) {
        throw const _LocationException('Necesitamos permiso de ubicación para validar esta misión.');
      }
      if (permission == LocationPermission.deniedForever) {
        throw const _LocationException('El permiso de ubicación está bloqueado. Actívalo desde Ajustes del teléfono.');
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      ).timeout(const Duration(seconds: 18));

      final meters = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        widget.mission.location.latitude,
        widget.mission.location.longitude,
      );

      if (!mounted) return;
      setState(() {
        _distanceMeters = meters;
      });

      if (meters > widget.mission.radiusMeters) {
        setState(() {
          _isError = true;
          _message = 'Aún estás fuera del área de la misión. Acércate unos ${((meters - widget.mission.radiusMeters).clamp(0, 999999)).round()} m más.';
        });
        return;
      }

      ref.read(playerProvider.notifier).completeMission(
        missionId: widget.mission.id,
        rewardXp: widget.mission.xp,
      );

      setState(() {
        _message = 'Ubicación verificada. ¡Misión completada! +${widget.mission.xp} XP.';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('+${widget.mission.xp} XP · misión completada')),
        );
      }
    } on _LocationException catch (e) {
      if (!mounted) return;
      setState(() {
        _isError = true;
        _message = e.message;
      });
    } on Exception catch (e) {
      if (!mounted) return;
      setState(() {
        _isError = true;
        _message = e.toString().replaceFirst('Exception: ', 'No pudimos obtener tu ubicación: ');
      });
    } finally {
      if (mounted) setState(() => _checkingLocation = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final player = ref.watch(playerProvider);
    final completed = player.completedMissionIds.contains(widget.mission.id);
    final started = player.startedMissionIds.contains(widget.mission.id);

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de misión')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(22),
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(color: AppColors.surfaceHigh, borderRadius: BorderRadius.circular(22)),
              child: Icon(widget.mission.icon, color: AppColors.primary, size: 86),
            ),
            const SizedBox(height: 24),
            Text(widget.mission.category.toUpperCase(), style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(widget.mission.title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            Text(widget.mission.description),
            const SizedBox(height: 22),
            ListTile(
              leading: const Icon(Icons.place),
              title: Text(widget.mission.locationName),
              subtitle: Text('${widget.mission.location.latitude.toStringAsFixed(4)}, ${widget.mission.location.longitude.toStringAsFixed(4)}'),
            ),
            ListTile(
              leading: const Icon(Icons.radar, color: AppColors.primary),
              title: Text('Radio de validación: ${widget.mission.radiusMeters} m'),
              subtitle: const Text('Debes estar físicamente dentro de esta zona.'),
            ),
            ListTile(
              leading: const Icon(Icons.stars, color: AppColors.primary),
              title: Text('+${widget.mission.xp} XP'),
              subtitle: Text('Dificultad: ${widget.mission.difficulty}'),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  completed
                      ? 'Misión completada. El XP ya fue añadido a tu progreso.'
                      : started
                          ? 'Misión iniciada. Cuando llegues al punto, verifica tu ubicación para reclamar el XP.'
                          : 'Primero inicia la misión. Después podrás validar tu ubicación cuando llegues al punto.',
                ),
              ),
            ),
            if (_distanceMeters != null) ...[
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: Icon(
                    _distanceMeters! <= widget.mission.radiusMeters ? Icons.check_circle : Icons.near_me,
                    color: _distanceMeters! <= widget.mission.radiusMeters ? AppColors.primary : AppColors.textMuted,
                  ),
                  title: Text('${_distanceMeters! < 1000 ? _distanceMeters!.round() : (_distanceMeters! / 1000).toStringAsFixed(1)} ${_distanceMeters! < 1000 ? 'm' : 'km'} de la misión'),
                  subtitle: Text(_distanceMeters! <= widget.mission.radiusMeters ? 'Estás dentro del área de validación.' : 'Todavía estás fuera del área.'),
                ),
              ),
            ],
            if (_message != null) ...[
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Icon(_isError ? Icons.info_outline : Icons.verified, color: _isError ? AppColors.textMuted : AppColors.primary),
                      const SizedBox(width: 12),
                      Expanded(child: Text(_message!)),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 14),
            if (!completed && !started)
              FilledButton.icon(
                onPressed: () {
                  ref.read(playerProvider.notifier).startMission(widget.mission.id);
                  setState(() {
                    _message = 'Misión iniciada. Ve al punto y luego verifica tu ubicación.';
                    _isError = false;
                  });
                },
                icon: const Icon(Icons.flag),
                label: const Text('Iniciar misión'),
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
              )
            else if (!completed)
              FilledButton.icon(
                onPressed: _checkingLocation ? null : _verifyLocation,
                icon: _checkingLocation
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.my_location),
                label: Text(_checkingLocation ? 'Verificando ubicación…' : 'Verificar ubicación'),
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
              )
            else
              FilledButton.icon(
                onPressed: null,
                icon: const Icon(Icons.check),
                label: const Text('Misión completada'),
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
              ),
          ],
        ),
      ),
    );
  }
}

class _LocationException implements Exception {
  const _LocationException(this.message);
  final String message;
}
