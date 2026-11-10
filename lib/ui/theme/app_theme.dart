import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const primaryColor = Colors.deepPurple;

  static final colorScheme = ColorScheme.fromSeed(seedColor: primaryColor);
  static final _baseTextTheme = Typography.material2021().black;

  static final textTheme = _baseTextTheme
      .copyWith(
        headlineMedium: _baseTextTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: _baseTextTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        titleLarge: _baseTextTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      )
      .apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      );

  static final theme = ThemeData(
    colorScheme: colorScheme,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      titleTextStyle: textTheme.titleLarge,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
