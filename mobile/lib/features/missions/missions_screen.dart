import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/player/player_state.dart';
import '../../core/theme/app_theme.dart';
import 'demo_missions.dart';
import 'mission_detail_screen.dart';

class MissionsScreen extends ConsumerWidget {
  const MissionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerProvider);
    final available = demoMissions.where((m) => !player.completedMissionIds.contains(m.id)).toList();
    final completed = demoMissions.where((m) => player.completedMissionIds.contains(m.id)).toList();
    final text = Theme.of(context).textTheme;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Misiones', style: text.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text('${available.length} disponibles · ${completed.length} completadas', style: text.bodyMedium?.copyWith(color: AppColors.textMuted)),
                  ],
                ),
              ),
              _XpBadge(xp: player.xp, level: player.level),
            ],
          ),
          const SizedBox(height: 22),
          _ProgressCard(player: player),
          const SizedBox(height: 24),
          Text('Disponibles', style: text.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          if (available.isEmpty)
            _EmptyState(onExplore: () => context.go('/explore'))
          else
            for (final mission in available) ...[
              _MissionCard(mission: mission, completed: false),
              const SizedBox(height: 10),
            ],
          if (completed.isNotEmpty) ...[
            const SizedBox(height: 18),
            Text('Completadas', style: text.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            for (final mission in completed) ...[
              _MissionCard(mission: mission, completed: true),
              const SizedBox(height: 10),
            ],
          ],
        ],
      ),
    );
  }
}

class _XpBadge extends StatelessWidget {
  const _XpBadge({required this.xp, required this.level});
  final int xp;
  final int level;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text('NV. $level', style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
          Text('$xp XP', style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({required this.player});
  final PlayerState player;

  @override
  Widget build(BuildContext context) {
    final nextLevel = player.level + 1;
    final nextXp = player.xp + (100 * player.level);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text('Nivel ${player.level}', style: const TextStyle(fontWeight: FontWeight.w800)),
              const Spacer(),
              Text('Siguiente: $nextLevel', style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
            ]),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(value: player.levelProgress, minHeight: 9),
            ),
            const SizedBox(height: 8),
            Text('$nextXp XP para alcanzar el nivel $nextLevel', style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _MissionCard extends StatelessWidget {
  const _MissionCard({required this.mission, required this.completed});
  final DemoMission mission;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => MissionDetailScreen(mission: mission))),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: completed ? Colors.green.withValues(alpha: 0.15) : AppColors.primary.withValues(alpha: 0.15),
                child: Icon(completed ? Icons.check : mission.icon, color: completed ? Colors.greenAccent : AppColors.primary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(mission.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text('${mission.category} · ${mission.difficulty}', style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(mission.locationName, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                  ],
                ),
              ),
              Text(completed ? '✓' : '+${mission.xp}', style: TextStyle(color: completed ? Colors.greenAccent : AppColors.primary, fontWeight: FontWeight.w800)),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onExplore});
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            const Icon(Icons.emoji_events, size: 46, color: AppColors.primary),
            const SizedBox(height: 12),
            const Text('Has completado todas las misiones demo.', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            const Text('Explora el mapa para revisar tus puntos de interés.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textMuted)),
            const SizedBox(height: 14),
            OutlinedButton.icon(onPressed: onExplore, icon: const Icon(Icons.map), label: const Text('Abrir mapa')),
          ],
        ),
      ),
    );
  }
}
