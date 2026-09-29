import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.person, size: 56, color: AppColors.primary),
            const SizedBox(height: 16),
            Text('Perfil', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            const Text('Aquí irán tu nivel, insignias e historial.', style: TextStyle(color: AppColors.textMuted)),
          ],
        ),
      ),
    );
  }
}
