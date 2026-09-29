import 'package:flutter_test/flutter_test.dart';
import 'package:sidequest/core/game/progression.dart';
import 'package:sidequest/core/player/badges.dart';
import 'package:sidequest/core/player/player_state.dart';

void main() {
  group('Progresión', () {
    test('calcula niveles según XP', () {
      expect(Progression.levelFromXp(0), 1);
      expect(Progression.levelFromXp(99), 1);
      expect(Progression.levelFromXp(100), 2);
      expect(Progression.levelFromXp(299), 2);
      expect(Progression.levelFromXp(300), 3);
    });

    test('calcula progreso hacia el siguiente nivel', () {
      expect(Progression.progressToNext(0), 0);
      expect(Progression.progressToNext(50), 0.5);
      expect(Progression.progressToNext(100), 0);
    });
  });

  group('Jugador', () {
    test('completar una misión otorga XP una sola vez', () {
      const initial = PlayerState();
      final completed = initial.completeMission(missionId: 'test', rewardXp: 80);
      final duplicate = completed.completeMission(missionId: 'test', rewardXp: 80);

      expect(completed.xp, 80);
      expect(completed.completedMissionIds, contains('test'));
      expect(duplicate.xp, 80);
    });

    test('iniciar una misión no otorga XP', () {
      const initial = PlayerState();
      final started = initial.startMission('test');

      expect(started.xp, 0);
      expect(started.startedMissionIds, contains('test'));
    });
  });

  group('Insignias', () {
    test('desbloquea primera aventura al completar una misión', () {
      final badges = buildBadges(completedMissionIds: {'plaza-mayor'}, xp: 50);
      expect(badges.firstWhere((b) => b.id == 'first-step').isUnlocked, isTrue);
    });

    test('desbloquea explorador urbano con tres misiones', () {
      final badges = buildBadges(
        completedMissionIds: {'plaza-mayor', 'parque-reserva', 'parque-kennedy'},
        xp: 190,
      );
      expect(badges.firstWhere((b) => b.id == 'explorer').isUnlocked, isTrue);
    });
  });
}
