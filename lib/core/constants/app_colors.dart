import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color(0xFF0C6CF2);
  static const Color primaryDark = Color(0xFF0054D4);
  static const Color primaryLight = Color(0xFF5E9BFF);
  static const Color secondary = Color(0xFFFFC107);
  static const Color accent = Color(0xFFFF5722);
  static const Color scaffoldBackground = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFF8F9FA);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color border = Color(0xFFE0E0E0);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryDark],
  );
}