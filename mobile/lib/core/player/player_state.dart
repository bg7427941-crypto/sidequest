import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../game/progression.dart';

class PlayerState {
  const PlayerState({this.xp = 0, this.completedMissionIds = const {}, this.startedMissionIds = const {}});

  final int xp;
  final Set<String> completedMissionIds;
  final Set<String> startedMissionIds;

  int get level => Progression.levelFromXp(xp);
  double get levelProgress => Progression.progressToNext(xp);

  PlayerState startMission(String missionId) {
    if (completedMissionIds.contains(missionId)) return this;
    return PlayerState(
      xp: xp,
      completedMissionIds: completedMissionIds,
      startedMissionIds: {...startedMissionIds, missionId},
    );
  }

  PlayerState completeMission({required String missionId, required int rewardXp}) {
    if (completedMissionIds.contains(missionId)) return this;

    return PlayerState(
      xp: xp + rewardXp,
      completedMissionIds: {...completedMissionIds, missionId},
      startedMissionIds: {...startedMissionIds, missionId},
    );
  }
}

class PlayerController extends Notifier<PlayerState> {
  @override
  PlayerState build() => const PlayerState();

  void startMission(String missionId) {
    state = state.startMission(missionId);
  }

  void completeMission({required String missionId, required int rewardXp}) {
    state = state.completeMission(missionId: missionId, rewardXp: rewardXp);
  }
}

final playerProvider = NotifierProvider<PlayerController, PlayerState>(PlayerController.new);
