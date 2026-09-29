import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/player/badges.dart';
import '../../core/player/player_state.dart';
import '../../core/theme/app_theme.dart';
import '../missions/demo_missions.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerProvider);
    final completed = demoMissions.where((m) => player.completedMissionIds.contains(m.id)).toList();
    final badges = buildBadges(completedMissionIds: player.completedMissionIds, xp: player.xp);
    final unlocked = badges.where((b) => b.isUnlocked).length;
    final text = Theme.of(context).textTheme;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        children: [
          Text('Perfil', style: text.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [AppColors.surfaceHigh, AppColors.surface],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.35)),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.16),
                  child: const Icon(Icons.person, size: 42, color: AppColors.primary),
                ),
                const SizedBox(height: 12),
                Text('Explorador', style: text.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text('Nivel ${player.level}', style: const TextStyle(color: AppColors.textMuted)),
                const SizedBox(height: 18),
                Row(children: [
                  Text('${player.xp} XP', style: const TextStyle(fontWeight: FontWeight.w800)),
                  const Spacer(),
                  Text('Nivel ${player.level + 1}', style: const TextStyle(color: AppColors.textMuted)),
                ]),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(value: player.levelProgress, minHeight: 10),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(children: [
            Expanded(child: _StatCard(icon: Icons.flag, value: '${completed.length}', label: 'Completadas')),
            const SizedBox(width: 10),
            Expanded(child: _StatCard(icon: Icons.stars, value: '${player.xp}', label: 'XP total')),
            const SizedBox(width: 10),
            Expanded(child: _StatCard(icon: Icons.workspace_premium, value: '$unlocked', label: 'Logros')),
          ]),
          const SizedBox(height: 26),
          Text('Insignias', style: text.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [for (final badge in badges) _BadgeTile(badge: badge)],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Historial de exploración', style: text.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          if (completed.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Text(
                  'Todavía no has completado misiones. Tu historial aparecerá aquí después de validar tu primera ubicación.',
                  style: TextStyle(color: AppColors.textMuted),
                ),
              ),
            )
          else
            for (final mission in completed)
              Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                    child: Icon(mission.icon, color: AppColors.primary),
                  ),
                  title: Text(mission.title),
                  subtitle: Text('${mission.locationName} · +${mission.xp} XP', style: const TextStyle(color: AppColors.textMuted)),
                  trailing: const Icon(Icons.check_circle, color: AppColors.primary),
                ),
              ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => _confirmReset(context, ref),
            icon: const Icon(Icons.restart_alt),
            label: const Text('Reiniciar progreso de demo'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmReset(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reiniciar progreso'),
        content: const Text('Se eliminarán el XP, las misiones iniciadas y las completadas guardadas en este dispositivo.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Reiniciar')),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(playerProvider.notifier).resetProgress();
    }
  }
}

class _BadgeTile extends StatelessWidget {
  const _BadgeTile({required this.badge});
  final AchievementBadge badge;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: badge.isUnlocked ? AppColors.primary.withValues(alpha: 0.15) : AppColors.surfaceHigh,
        child: Text(badge.isUnlocked ? badge.icon : '🔒', style: const TextStyle(fontSize: 20)),
      ),
      title: Text(badge.name, style: TextStyle(fontWeight: FontWeight.w700, color: badge.isUnlocked ? null : AppColors.textMuted)),
      subtitle: Text(badge.description, style: const TextStyle(color: AppColors.textMuted)),
      trailing: badge.isUnlocked ? const Icon(Icons.check_circle, color: AppColors.primary) : null,
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.icon, required this.value, required this.label});
  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            children: [
              Icon(icon, color: AppColors.primary),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
            ],
          ),
        ),
      );
}
