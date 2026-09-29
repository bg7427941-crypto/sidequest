import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../game/progression.dart';

class PlayerState {
  const PlayerState({this.xp = 0, this.completedMissionIds = const {}});

  final int xp;
  final Set<String> completedMissionIds;

  int get level => Progression.levelFromXp(xp);
  double get levelProgress => Progression.progressToNext(xp);

  PlayerState completeMission({required String missionId, required int rewardXp}) {
    if (completedMissionIds.contains(missionId)) return this;

    return PlayerState(
      xp: xp + rewardXp,
      completedMissionIds: {...completedMissionIds, missionId},
    );
  }
}

class PlayerController extends Notifier<PlayerState> {
  @override
  PlayerState build() => const PlayerState();

  void completeMission({required String missionId, required int rewardXp}) {
    state = state.completeMission(missionId: missionId, rewardXp: rewardXp);
  }
}

final playerProvider = NotifierProvider<PlayerController, PlayerState>(PlayerController.new);
