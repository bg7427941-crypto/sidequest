/// Central place for XP/level rules. Reaching level L+1 from L costs
/// [xpPerLevel] * L, so total XP to reach level L is
/// xpPerLevel * L * (L - 1) / 2.
class Progression {
  static const int xpPerLevel = 100;

  static int totalXpForLevel(int level) => xpPerLevel * level * (level - 1) ~/ 2;

  static int levelFromXp(int xp) {
    var level = 1;
    while (totalXpForLevel(level + 1) <= xp) {
      level++;
    }
    return level;
  }

  /// Progress (0..1) toward the next level.
  static double progressToNext(int xp) {
    final level = levelFromXp(xp);
    final start = totalXpForLevel(level);
    final end = totalXpForLevel(level + 1);
    return (xp - start) / (end - start);
  }
}
