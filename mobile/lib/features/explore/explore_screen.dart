import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../core/theme/app_theme.dart';
import '../../core/player/player_state.dart';
import '../missions/demo_missions.dart';
import '../missions/mission_detail_screen.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});
  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final _map = MapController();
  static const _lima = LatLng(-12.0900, -77.0400);
  String _category = 'Todas';
  String _difficulty = 'Todas';
  double _maxDistanceKm = 30;
  Position? _position;
  DemoMission? _selected;
  String? _locationMessage;
  bool _loadingLocation = false;
  final _distance = const Distance();

  List<DemoMission> get _visible => demoMissions.where((m) {
    if (_category != 'Todas' && m.category != _category) return false;
    if (_difficulty != 'Todas' && m.difficulty != _difficulty) return false;
    final origin = _position == null ? _lima : LatLng(_position!.latitude, _position!.longitude);
    return _distance.as(LengthUnit.Kilometer, origin, m.location) <= _maxDistanceKm;
  }).toList();

  Future<void> _locate() async {
    if (_loadingLocation) return;
    setState(() { _loadingLocation = true; _locationMessage = null; });
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw Exception('Activa el GPS para ver tu ubicación.');
      }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        throw Exception('Permiso denegado. Puedes seguir explorando el mapa manualmente.');
      }
      final pos = await Geolocator.getCurrentPosition(locationSettings: const LocationSettings(accuracy: LocationAccuracy.high)).timeout(const Duration(seconds: 18));
      if (!mounted) return;
      setState(() => _position = pos);
      _map.move(LatLng(pos.latitude, pos.longitude), 14);
    } catch (e) {
      if (!mounted) return;
      setState(() => _locationMessage = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _loadingLocation = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final origin = _position == null ? _lima : LatLng(_position!.latitude, _position!.longitude);
    return SafeArea(child: Stack(children: [
      FlutterMap(mapController: _map, options: MapOptions(initialCenter: _lima, initialZoom: 12,
        onTap: (_, __) => setState(() => _selected = null)), children: [
        TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.sidequest.sidequest', maxNativeZoom: 19),
        MarkerLayer(markers: [
          if (_position != null) Marker(point: origin, width: 48, height: 48,
            child: const Icon(Icons.my_location, color: Colors.lightBlueAccent, size: 34)),
          for (final m in _visible) Marker(point: m.location, width: 54, height: 54,
            child: GestureDetector(onTap: () { setState(() => _selected = m); _map.move(m.location, 14); },
              child: Container(decoration: BoxDecoration(color: AppColors.surface, shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 2), boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 9)]),
                child: Icon(m.icon, color: AppColors.primary)))),
        ]),
        const RichAttributionWidget(attributions: [TextSourceAttribution('© OpenStreetMap contributors')]),
      ]),
      Positioned(top: 12, left: 12, right: 12, child: Card(color: AppColors.surface,
        child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('EXPLORAR LIMA', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800, letterSpacing: 1.5)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: [
            DropdownButton<String>(value: _category, underline: const SizedBox(), items: ['Todas','Exploración','Naturaleza','Fotografía','Cultura e historia']
              .map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(), onChanged: (x) => setState(() => _category = x!)),
            DropdownButton<String>(value: _difficulty, underline: const SizedBox(), items: ['Todas','Fácil','Media']
              .map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(), onChanged: (x) => setState(() => _difficulty = x!)),
          ]),
          Row(children: [Text('Radio: ${_maxDistanceKm.round()} km', style: const TextStyle(fontSize: 12)),
            Expanded(child: Slider(value: _maxDistanceKm, min: 1, max: 50, divisions: 49, onChanged: (v) => setState(() => _maxDistanceKm = v)))]),
          Text('${_visible.length} misiones de demostración · Distancia ${_position == null ? 'desde Lima centro' : 'desde tu ubicación'}',
            style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
        ])))),
      Positioned(right: 16, bottom: _selected == null ? 22 : 205, child: FloatingActionButton(
        heroTag: 'locate', onPressed: _loadingLocation ? null : _locate,
        child: _loadingLocation ? const CircularProgressIndicator(strokeWidth: 2) : const Icon(Icons.my_location))),
      if (_locationMessage != null) Positioned(left: 16, right: 16, bottom: _selected == null ? 90 : 270,
        child: Card(child: Padding(padding: const EdgeInsets.all(12), child: Row(children: [
          Expanded(child: Text(_locationMessage!)), IconButton(icon: const Icon(Icons.close), onPressed: () => setState(() => _locationMessage = null))])))),
      if (_selected != null) Positioned(left: 12, right: 12, bottom: 12, child: Card(child: Padding(
        padding: const EdgeInsets.all(16), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(_selected!.category.toUpperCase(), style: const TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6), Text(_selected!.title, style: Theme.of(context).textTheme.titleLarge),
          Text(_selected!.locationName, style: const TextStyle(color: AppColors.textMuted)),
          const SizedBox(height: 6), Text('${_distance.as(LengthUnit.Kilometer, origin, _selected!.location).toStringAsFixed(1)} km en línea recta · +${_selected!.xp} XP'),
          const SizedBox(height: 12), SizedBox(width: double.infinity, child: FilledButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => MissionDetailScreen(mission: _selected!))),
            child: const Text('Ver misión'))),
        ])))),
    ]));
  }
}
