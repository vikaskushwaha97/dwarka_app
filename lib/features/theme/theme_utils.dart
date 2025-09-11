import 'package:flutter/material.dart';

Color textFieldBackgroundColor(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF4F4F4);
}

Color textFieldPlaceholderColor(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return isDark ? Colors.white70 : const Color(0xFF272727).withOpacity(0.5);
}


