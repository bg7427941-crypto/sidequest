import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Map<String, dynamic> toJson() => {
        'xp': xp,
        'completedMissionIds': completedMissionIds.toList(),
        'startedMissionIds': startedMissionIds.toList(),
      };

  factory PlayerState.fromJson(Map<String, dynamic> json) => PlayerState(
        xp: (json['xp'] as num?)?.toInt() ?? 0,
        completedMissionIds: Set<String>.from((json['completedMissionIds'] as List<dynamic>? ?? const []).map((e) => e.toString())),
        startedMissionIds: Set<String>.from((json['startedMissionIds'] as List<dynamic>? ?? const []).map((e) => e.toString())),
      );
}

class PlayerController extends Notifier<PlayerState> {
  static const _storageKey = 'sidequest_player_state_v1';
  bool _loading = true;

  @override
  PlayerState build() {
    _load();
    ref.onDispose(() {});
    return const PlayerState();
  }

  Future<void> _load() async {
    if (!_loading) return;
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw != null) {
      try {
        state = PlayerState.fromJson(jsonDecode(raw) as Map<String, dynamic>);
      } catch (_) {
        // Ignore malformed local data and start with a clean profile.
      }
    }
    _loading = false;
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(state.toJson()));
  }

  void startMission(String missionId) {
    state = state.startMission(missionId);
    _persist();
  }

  void completeMission({required String missionId, required int rewardXp}) {
    final next = state.completeMission(missionId: missionId, rewardXp: rewardXp);
    if (identical(next, state)) return;
    state = next;
    _persist();
  }

  Future<void> resetProgress() async {
    state = const PlayerState();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}

final playerProvider = NotifierProvider<PlayerController, PlayerState>(PlayerController.new);
