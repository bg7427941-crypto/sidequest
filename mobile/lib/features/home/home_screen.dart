import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/game/progression.dart';
import '../../core/theme/app_theme.dart';
import '../missions/demo_missions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _demoXp = 260;

  @override
  Widget build(BuildContext context) {
    final level = Progression.levelFromXp(_demoXp);
    final progress = Progression.progressToNext(_demoXp);
    final text = Theme.of(context).textTheme;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Hola, explorador', style: text.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text('¿Listo para tu próxima misión?', style: text.bodyMedium?.copyWith(color: AppColors.textMuted)),
          const SizedBox(height: 20),
          _LevelCard(level: level, xp: _demoXp, progress: progress),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => context.go('/explore'),
            icon: const Icon(Icons.map),
            label: const Text('Abrir mapa'),
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
          ),
          const SizedBox(height: 24),
          Text('Misiones cercanas (demo)', style: text.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          for (final m in demoMissions) ...[
            _MissionTile(mission: m),
            const SizedBox(height: 10),
          ],
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
        gradient: const LinearGradient(
          colors: [AppColors.surfaceHigh, AppColors.surface],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Nivel $level', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              const Spacer(),
              Text('$xp XP', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: AppColors.background,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _MissionTile extends StatelessWidget {
  const _MissionTile({required this.mission});

  final DemoMission mission;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withValues(alpha: 0.15),
          child: Icon(mission.icon, color: AppColors.primary),
        ),
        title: Text(mission.title),
        subtitle: Text('${mission.category} · ${mission.distanceKm} km', style: const TextStyle(color: AppColors.textMuted)),
        trailing: Text('+${mission.xp} XP', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
