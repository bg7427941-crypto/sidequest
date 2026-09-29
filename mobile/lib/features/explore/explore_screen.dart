import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.map, size: 56, color: AppColors.primary),
            const SizedBox(height: 16),
            Text('Explorar', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            const Text('El mapa interactivo llega en la Fase 2.', style: TextStyle(color: AppColors.textMuted)),
          ],
        ),
      ),
    );
  }
}
