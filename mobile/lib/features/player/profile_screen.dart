import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/player/player_state.dart';
import '../../core/theme/app_theme.dart';
import '../missions/demo_missions.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerProvider);
    final completed = demoMissions.where((m) => player.completedMissionIds.contains(m.id)).toList();
    final text = Theme.of(context).textTheme;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(children: [
            CircleAvatar(radius: 34, backgroundColor: AppColors.primary.withValues(alpha: 0.15), child: const Icon(Icons.person, size: 38, color: AppColors.primary)),
            const SizedBox(width: 14),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Explorador', style: text.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              Text('Nivel ${player.level} · ${player.xp} XP', style: const TextStyle(color: AppColors.textMuted)),
            ]),
          ]),
          const SizedBox(height: 22),
          Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Progreso de nivel', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: player.levelProgress, minHeight: 9)),
          ]))),
          const SizedBox(height: 18),
          Row(children: [
            Expanded(child: _StatCard(icon: Icons.flag, value: '${completed.length}', label: 'Completadas')),
            const SizedBox(width: 10),
            Expanded(child: _StatCard(icon: Icons.stars, value: '${player.xp}', label: 'XP total')),
          ]),
          const SizedBox(height: 24),
          Text('Historial', style: text.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          if (completed.isEmpty)
            const Card(child: Padding(padding: EdgeInsets.all(18), child: Text('Todavía no has completado misiones. Tu historial aparecerá aquí.', style: TextStyle(color: AppColors.textMuted))))
          else
            for (final mission in completed)
              Card(margin: const EdgeInsets.only(bottom: 8), child: ListTile(leading: const Icon(Icons.check_circle, color: Colors.greenAccent), title: Text(mission.title), subtitle: Text('+${mission.xp} XP · ${mission.locationName}', style: const TextStyle(color: AppColors.textMuted)))),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.icon, required this.value, required this.label});
  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
    Icon(icon, color: AppColors.primary),
    const SizedBox(height: 8),
    Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
    Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
  ])));
}
