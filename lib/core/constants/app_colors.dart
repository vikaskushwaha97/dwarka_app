import 'package:flutter/material.dart';

abstract class AppColors {
// ================ PRIMARY COLORS ================ //
static const Color primary = Color(0xFF0C6CF2);
static const Color primaryDark = Color(0xFF0054D4);
static const Color primaryLight = Color(0xFF5E9BFF);
static const Color secondary = Color(0xFFFFC107);
static const Color accent = Color(0xFFFF5722);

// ================ LIGHT THEME COLORS ================ //
static const Color textFieldBackgroundLight = Color(0xFFF5F5F5);
static const Color textFieldPlaceholderLight = Color(0xFF757575);
static const Color cardBackgroundLight = Color(0xFFFFFFFF);
static const Color scaffoldBackgroundLight = Color(0xFFFAFAFA);
static const Color textPrimaryLight = Color(0xFF212121);
static const Color textSecondaryLight = Color(0xFF757575);

// ================ DARK THEME COLORS ================ //
static const Color textFieldBackgroundDark = Color(0xFF1E1E1E);
static const Color textFieldPlaceholderDark = Color(0xFFAAAAAA);
static const Color cardBackgroundDark = Color(0xFF2D2D2D);
static const Color scaffoldBackgroundDark = Color(0xFF121212);
static const Color textPrimaryDark = Color(0xFFFFFFFF);
static const Color textSecondaryDark = Color(0xFFB0B0B0);

// ================ SEMANTIC COLORS ================ //
static const Color disabledLight = Color(0xFFE0E0E0);
static const Color disabledDark = Color(0xFF424242);
static const Color errorLight = Color(0xFFD32F2F);
static const Color errorDark = Color(0xFFCF6679);
static const Color successLight = Color(0xFF388E3C); // Green 700
static const Color successDark = Color(0xFF81C784);  // Green 300
static const Color warningLight = Color(0xFFFFA000); // Amber 700
static const Color warningDark = Color(0xFFFFB74D);  // Amber 300
static const Color infoLight = Color(0xFF1976D2);    // Blue 700
static const Color infoDark = Color(0xFF64B5F6);     // Blue 300

// ================ LEGACY COLORS (for backward compatibility) ================ //
static const Color scaffoldBackground = Color(0xFFFFFFFF);
static const Color cardBackground = Color(0xFFF8F9FA);
static const Color textPrimary = Color(0xFF212121);
static const Color textSecondary = Color(0xFF757575);
static const Color border = Color(0xFFE0E0E0);
static const Color success = Color(0xFF4CAF50);
static const Color error = Color(0xFFF44336);
static const Color warning = Color(0xFFFF9800);
static const Color info = Color(0xFF2196F3);

// ================ GRADIENTS ================ //
static const Gradient primaryGradient = LinearGradient(
begin: Alignment.topLeft,
end: Alignment.bottomRight,
colors: [primary, primaryDark],
);

// ================ UTILITY METHODS ================ //

/// Returns the appropriate color based on theme brightness
static Color getAdaptiveColor({
required bool isDarkMode,
required Color light,
required Color dark,
}) {
return isDarkMode ? dark : light;
}

/// Returns text field background color based on theme
static Color getTextFieldBackground(bool isDarkMode) {
return getAdaptiveColor(
isDarkMode: isDarkMode,
light: textFieldBackgroundLight,
dark: textFieldBackgroundDark,
);
}

/// Returns text field placeholder color based on theme
static Color getTextFieldPlaceholder(bool isDarkMode) {
return getAdaptiveColor(
isDarkMode: isDarkMode,
light: textFieldPlaceholderLight,
dark: textFieldPlaceholderDark,
);
}

/// Returns card background color based on theme
static Color getCardBackground(bool isDarkMode) {
return getAdaptiveColor(
isDarkMode: isDarkMode,
light: cardBackgroundLight,
dark: cardBackgroundDark,
);
}

/// Returns scaffold background color based on theme
static Color getScaffoldBackground(bool isDarkMode) {
return getAdaptiveColor(
isDarkMode: isDarkMode,
light: scaffoldBackgroundLight,
dark: scaffoldBackgroundDark,
);
}

/// Returns primary text color based on theme
static Color getTextPrimary(bool isDarkMode) {
return getAdaptiveColor(
isDarkMode: isDarkMode,
light: textPrimaryLight,
dark: textPrimaryDark,
);
}

/// Returns secondary text color based on theme
static Color getTextSecondary(bool isDarkMode) {
return getAdaptiveColor(
isDarkMode: isDarkMode,
light: textSecondaryLight,
dark: textSecondaryDark,
);
}

/// Returns disabled color based on theme
static Color getDisabled(bool isDarkMode) {
return getAdaptiveColor(
isDarkMode: isDarkMode,
light: disabledLight,
dark: disabledDark,
);
}

/// Returns error color based on theme
static Color getError(bool isDarkMode) {
return getAdaptiveColor(
isDarkMode: isDarkMode,
light: errorLight,
dark: errorDark,
);
}

/// Returns success color based on theme
static Color getSuccess(bool isDarkMode) {
return getAdaptiveColor(
isDarkMode: isDarkMode,
light: successLight,
dark: successDark,
);
}

/// Returns warning color based on theme
static Color getWarning(bool isDarkMode) {
return getAdaptiveColor(
isDarkMode: isDarkMode,
light: warningLight,
dark: warningDark,
);
}

/// Returns info color based on theme
static Color getInfo(bool isDarkMode) {
return getAdaptiveColor(
isDarkMode: isDarkMode,
light: infoLight,
dark: infoDark,
);
}
}
