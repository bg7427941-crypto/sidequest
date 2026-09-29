import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class MissionsScreen extends StatelessWidget {
  const MissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.flag, size: 56, color: AppColors.primary),
            const SizedBox(height: 16),
            Text('Misiones', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            const Text('Aquí verás misiones disponibles, iniciadas y completadas.', style: TextStyle(color: AppColors.textMuted)),
          ],
        ),
      ),
    );
  }
}
