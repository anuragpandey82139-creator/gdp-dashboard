import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const _navy = Color(0xFF142B4A);
  static const _blue = Color(0xFF2864D8);

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _blue,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFFF4F7FB),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF4F7FB),
        foregroundColor: _navy,
        surfaceTintColor: Colors.transparent,
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          color: _navy,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        titleLarge: TextStyle(color: _navy, fontWeight: FontWeight.w700),
        titleMedium: TextStyle(color: _navy, fontWeight: FontWeight.w700),
        bodyMedium: TextStyle(color: Color(0xFF59677B)),
      ),
    );
  }
}
