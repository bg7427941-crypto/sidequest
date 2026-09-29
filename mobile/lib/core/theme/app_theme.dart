import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF0B1220);
  static const surface = Color(0xFF131C2E);
  static const surfaceHigh = Color(0xFF1B2740);
  static const primary = Color(0xFFFF7A1A);
  static const textMuted = Color(0xFF8B97AD);
}

class AppTheme {
  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ).copyWith(primary: AppColors.primary, surface: AppColors.surface);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primary.withValues(alpha: 0.2),
      ),
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.background, elevation: 0),
    );
  }
}
