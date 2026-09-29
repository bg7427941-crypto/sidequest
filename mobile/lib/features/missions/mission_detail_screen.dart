import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/player/player_state.dart';
import '../../core/theme/app_theme.dart';
import 'demo_missions.dart';

class MissionDetailScreen extends ConsumerWidget {
  const MissionDetailScreen({super.key, required this.mission});

  final DemoMission mission;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerProvider);
    final completed = player.completedMissionIds.contains(mission.id);

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de misión')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(22),
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(color: AppColors.surfaceHigh, borderRadius: BorderRadius.circular(22)),
              child: Icon(mission.icon, color: AppColors.primary, size: 86),
            ),
            const SizedBox(height: 24),
            Text(mission.category.toUpperCase(), style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(mission.title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            Text(mission.description),
            const SizedBox(height: 22),
            ListTile(
              leading: const Icon(Icons.place),
              title: Text(mission.locationName),
              subtitle: Text('${mission.location.latitude.toStringAsFixed(4)}, ${mission.location.longitude.toStringAsFixed(4)}'),
            ),
            ListTile(
              leading: const Icon(Icons.stars, color: AppColors.primary),
              title: Text('+${mission.xp} XP'),
              subtitle: Text('Dificultad: ${mission.difficulty}'),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(completed
                    ? 'Misión completada. El XP ya fue añadido a tu progreso.'
                    : 'Modo demo: puedes registrar la misión ahora. En la siguiente fase esta acción se protegerá con validación GPS.'),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: completed
                  ? null
                  : () {
                      ref.read(playerProvider.notifier).completeMission(missionId: mission.id, rewardXp: mission.xp);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Misión completada · +${mission.xp} XP')),
                      );
                    },
              icon: Icon(completed ? Icons.check : Icons.flag),
              label: Text(completed ? 'Misión completada' : 'Completar misión · Demo'),
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
            ),
          ],
        ),
      ),
    );
  }
}
