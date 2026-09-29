import '../game/progression.dart';
import '../../features/missions/demo_missions.dart';

class AchievementBadge {
  const AchievementBadge({required this.id, required this.name, required this.description, required this.icon, required this.isUnlocked});

  final String id;
  final String name;
  final String description;
  final String icon;
  final bool isUnlocked;
}

List<AchievementBadge> buildBadges({required Set<String> completedMissionIds, required int xp}) {
  final completed = completedMissionIds.length;
  final categories = demoMissions
      .where((mission) => completedMissionIds.contains(mission.id))
      .map((mission) => mission.category)
      .toSet();

  return [
    AchievementBadge(id: 'first-step', name: 'Primera aventura', description: 'Completa tu primera misión.', icon: '🧭', isUnlocked: completed >= 1),
    AchievementBadge(id: 'explorer', name: 'Explorador urbano', description: 'Completa 3 misiones.', icon: '🗺️', isUnlocked: completed >= 3),
    AchievementBadge(id: 'veteran', name: 'Veterano', description: 'Alcanza 300 XP.', icon: '🔥', isUnlocked: xp >= 300),
    AchievementBadge(id: 'multi-class', name: 'Explorador completo', description: 'Descubre misiones de 3 categorías.', icon: '🏆', isUnlocked: categories.length >= 3),
    AchievementBadge(id: 'level-five', name: 'Rango superior', description: 'Alcanza el nivel 5.', icon: '⭐', isUnlocked: Progression.levelFromXp(xp) >= 5),
  ];
}
