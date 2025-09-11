import 'package:flutter/material.dart';

/// Centralized light and dark theme definitions for the app.
/// Extend here for future themes or custom color schemes.
ThemeData _buildLightTheme() {
  final ColorScheme scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF9775FA),
    brightness: Brightness.light,
  );

  final TextTheme textTheme = Typography.material2021().black.copyWith(
    displayLarge: Typography.material2021().black.displayLarge?.copyWith(fontWeight: FontWeight.bold, color: scheme.onBackground),
    displayMedium: Typography.material2021().black.displayMedium?.copyWith(fontWeight: FontWeight.bold, color: scheme.onBackground),
    displaySmall: Typography.material2021().black.displaySmall?.copyWith(fontWeight: FontWeight.w600, color: scheme.onBackground),
    headlineLarge: Typography.material2021().black.headlineLarge?.copyWith(fontWeight: FontWeight.bold, color: scheme.onBackground),
    headlineMedium: Typography.material2021().black.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: scheme.onBackground),
    headlineSmall: Typography.material2021().black.headlineSmall?.copyWith(fontWeight: FontWeight.w600, color: scheme.onBackground),
    titleLarge: Typography.material2021().black.titleLarge?.copyWith(fontWeight: FontWeight.w600, color: scheme.onSurface),
    titleMedium: Typography.material2021().black.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: scheme.onSurface),
    titleSmall: Typography.material2021().black.titleSmall?.copyWith(fontWeight: FontWeight.w600, color: scheme.onSurface),
    bodyLarge: Typography.material2021().black.bodyLarge?.copyWith(color: scheme.onBackground),
    bodyMedium: Typography.material2021().black.bodyMedium?.copyWith(color: scheme.onBackground.withOpacity(0.9)),
    bodySmall: Typography.material2021().black.bodySmall?.copyWith(color: scheme.onBackground.withOpacity(0.7)),
    labelLarge: Typography.material2021().black.labelLarge?.copyWith(color: scheme.onSurface),
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: scheme,
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
      ),
    ),
  );
}

final ThemeData lightTheme = _buildLightTheme();

ThemeData _buildDarkTheme() {
  final ColorScheme scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF9775FA),
    brightness: Brightness.dark,
    background: const Color(0xFF121212),
    surface: const Color(0xFF1E1E1E),
  );

  final TextTheme textTheme = Typography.material2021().white.copyWith(
    displayLarge: Typography.material2021().white.displayLarge?.copyWith(fontWeight: FontWeight.bold, color: scheme.onBackground),
    displayMedium: Typography.material2021().white.displayMedium?.copyWith(fontWeight: FontWeight.bold, color: scheme.onBackground),
    displaySmall: Typography.material2021().white.displaySmall?.copyWith(fontWeight: FontWeight.w600, color: scheme.onBackground),
    headlineLarge: Typography.material2021().white.headlineLarge?.copyWith(fontWeight: FontWeight.bold, color: scheme.onBackground),
    headlineMedium: Typography.material2021().white.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: scheme.onBackground),
    headlineSmall: Typography.material2021().white.headlineSmall?.copyWith(fontWeight: FontWeight.w600, color: scheme.onBackground),
    titleLarge: Typography.material2021().white.titleLarge?.copyWith(fontWeight: FontWeight.w600, color: scheme.onSurface),
    titleMedium: Typography.material2021().white.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: scheme.onSurface),
    titleSmall: Typography.material2021().white.titleSmall?.copyWith(fontWeight: FontWeight.w600, color: scheme.onSurface),
    bodyLarge: Typography.material2021().white.bodyLarge?.copyWith(color: scheme.onBackground),
    bodyMedium: Typography.material2021().white.bodyMedium?.copyWith(color: scheme.onBackground.withOpacity(0.92)),
    bodySmall: Typography.material2021().white.bodySmall?.copyWith(color: scheme.onBackground.withOpacity(0.75)),
    labelLarge: Typography.material2021().white.labelLarge?.copyWith(color: scheme.onSurface),
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: scheme,
    scaffoldBackgroundColor: const Color(0xFF121212),
    canvasColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      surfaceTintColor: Colors.transparent,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF121212),
    ),
    textTheme: textTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
      ),
    ),
  );
}

final ThemeData darkTheme = _buildDarkTheme();


