import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/player/player_state.dart';
import '../../core/theme/app_theme.dart';
import '../missions/demo_missions.dart';
import '../../core/network/mission_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerProvider);
    final missionsAsync = ref.watch(missionsProvider);
    final missions = missionsAsync.valueOrNull ?? demoMissions;
    final text = Theme.of(context).textTheme;
    final nextMission = missions.firstWhere(
      (mission) => !player.completedMissionIds.contains(mission.id),
      orElse: () => missions.first,
    );

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Hola, explorador', style: text.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text('¿Listo para tu próxima misión?', style: text.bodyMedium?.copyWith(color: AppColors.textMuted)),
          const SizedBox(height: 20),
          _LevelCard(level: player.level, xp: player.xp, progress: player.levelProgress),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => context.go('/explore'),
            icon: const Icon(Icons.map),
            label: const Text('Abrir mapa'),
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
          ),
          const SizedBox(height: 24),
          Text('Siguiente misión', style: text.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          _MissionTile(mission: nextMission, completed: player.completedMissionIds.contains(nextMission.id)),
          const SizedBox(height: 18),
          Text('Tu progreso', style: text.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Text('${player.completedMissionIds.length}/${missions.length} misiones completadas'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  const _LevelCard({required this.level, required this.xp, required this.progress});

  final int level;
  final int xp;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(colors: [AppColors.surfaceHigh, AppColors.surface], begin: Alignment.topLeft, end: Alignment.bottomRight),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text('Nivel $level', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
            const Spacer(),
            Text('$xp XP', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 14),
          ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: progress, minHeight: 10)),
        ],
      ),
    );
  }
}

class _MissionTile extends StatelessWidget {
  const _MissionTile({required this.mission, required this.completed});

  final DemoMission mission;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(backgroundColor: AppColors.primary.withValues(alpha: 0.15), child: Icon(mission.icon, color: AppColors.primary)),
        title: Text(mission.title),
        subtitle: Text('${mission.category} · ${mission.locationName}', style: const TextStyle(color: AppColors.textMuted)),
        trailing: Text(completed ? '✓' : '+${mission.xp}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
