import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'demo_missions.dart';

class MissionDetailScreen extends StatelessWidget {
  const MissionDetailScreen({super.key, required this.mission});
  final DemoMission mission;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Detalle de misión')),
    body: SafeArea(child: ListView(padding: const EdgeInsets.all(22), children: [
      Container(height: 170, decoration: BoxDecoration(color: AppColors.surfaceHigh, borderRadius: BorderRadius.circular(22)),
        child: Icon(mission.icon, color: AppColors.primary, size: 86)),
      const SizedBox(height: 24), Text(mission.category.toUpperCase(), style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8), Text(mission.title, style: Theme.of(context).textTheme.headlineMedium),
      const SizedBox(height: 16), Text(mission.description),
      const SizedBox(height: 22), ListTile(leading: const Icon(Icons.place), title: Text(mission.locationName),
        subtitle: Text('${mission.location.latitude.toStringAsFixed(4)}, ${mission.location.longitude.toStringAsFixed(4)}')),
      ListTile(leading: const Icon(Icons.stars, color: AppColors.primary), title: Text('+${mission.xp} XP'), subtitle: Text('Dificultad: ${mission.difficulty}')),
      const SizedBox(height: 24), const Card(child: Padding(padding: EdgeInsets.all(16), child: Text(
        'Misión de demostración. La validación GPS, el registro de finalización y las recompensas reales se implementarán en la fase 4.'))),
      const SizedBox(height: 12), FilledButton(onPressed: null, child: const Text('Iniciar misión · Próximamente')),
    ])),
  );
}
