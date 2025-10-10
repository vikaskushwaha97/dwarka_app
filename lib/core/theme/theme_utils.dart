import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// A utility class for theme-related helper methods and constants.
/// Follows clean architecture principles and provides consistent theming across the app.
class ThemeUtils {
  // Private constructor to prevent instantiation
  ThemeUtils._();

  // ================ BORDER RADIUS CONSTANTS ================ //

  static const double borderRadiusNone = 0.0;
  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 8.0;
  static const double borderRadiusLarge = 12.0;
  static const double borderRadiusExtraLarge = 16.0;
  static const double borderRadiusCircular = 24.0;

  static BorderRadiusGeometry get borderRadiusSmallAll =>
      const BorderRadius.all(Radius.circular(borderRadiusSmall));
  static BorderRadiusGeometry get borderRadiusMediumAll =>
      const BorderRadius.all(Radius.circular(borderRadiusMedium));
  static BorderRadiusGeometry get borderRadiusLargeAll =>
      const BorderRadius.all(Radius.circular(borderRadiusLarge));
  static BorderRadiusGeometry get borderRadiusExtraLargeAll =>
      const BorderRadius.all(Radius.circular(borderRadiusExtraLarge));
  static BorderRadiusGeometry get borderRadiusCircularAll =>
      const BorderRadius.all(Radius.circular(borderRadiusCircular));

  // ================ SPACING CONSTANTS ================ //

  static const double spacingNone = 0.0;
  static const double spacingExtraSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingExtraLarge = 32.0;

  static EdgeInsets get spacingExtraSmallAll =>
      const EdgeInsets.all(spacingExtraSmall);
  static EdgeInsets get spacingSmallAll =>
      const EdgeInsets.all(spacingSmall);
  static EdgeInsets get spacingMediumAll =>
      const EdgeInsets.all(spacingMedium);
  static EdgeInsets get spacingLargeAll =>
      const EdgeInsets.all(spacingLarge);
  static EdgeInsets get spacingExtraLargeAll =>
      const EdgeInsets.all(spacingExtraLarge);

  static EdgeInsets spacingSymmetricHorizontal(double spacing) =>
      EdgeInsets.symmetric(horizontal: spacing);

  static EdgeInsets spacingSymmetricVertical(double spacing) =>
      EdgeInsets.symmetric(vertical: spacing);

  // ================ ELEVATION CONSTANTS ================ //

  static const double elevationNone = 0.0;
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  static const double elevationExtraHigh = 16.0;

  // ================ ANIMATION CONSTANTS ================ //

  static const Duration animationInstant = Duration(milliseconds: 100);
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  static const Duration animationDeliberate = Duration(milliseconds: 800);

  static const Curve animationStandard = Curves.easeInOut;
  static const Curve animationDecelerate = Curves.decelerate;
  static const Curve animationFastOutSlowIn = Curves.fastOutSlowIn;
  static const Curve animationBounce = Curves.bounceOut;
  static const Curve animationElastic = Curves.elasticOut;

  // ================ COLOR UTILITIES ================ //

  /// Returns the appropriate text field background color based on current theme
  static Color textFieldBackgroundColor(BuildContext context) {
    return _isDarkMode(context)
        ? AppColors.textFieldBackgroundDark
        : AppColors.textFieldBackgroundLight;
  }

  /// Returns the appropriate text field placeholder color based on current theme
  static Color textFieldPlaceholderColor(BuildContext context) {
    return _isDarkMode(context)
        ? AppColors.textFieldPlaceholderDark
        : AppColors.textFieldPlaceholderLight;
  }

  /// Returns adaptive color based on current theme mode
  static Color adaptiveColor({
    required BuildContext context,
    required Color light,
    required Color dark,
  }) {
    return _isDarkMode(context) ? dark : light;
  }

  /// Returns card color based on current theme
  static Color cardColor(BuildContext context) {
    return adaptiveColor(
      context: context,
      light: AppColors.cardBackgroundLight,
      dark: AppColors.cardBackgroundDark,
    );
  }

  /// Returns scaffold background color based on current theme
  static Color scaffoldBackgroundColor(BuildContext context) {
    return adaptiveColor(
      context: context,
      light: AppColors.scaffoldBackgroundLight,
      dark: AppColors.scaffoldBackgroundDark,
    );
  }

  /// Returns primary text color based on current theme
  static Color primaryTextColor(BuildContext context) {
    return adaptiveColor(
      context: context,
      light: AppColors.textPrimaryLight,
      dark: AppColors.textPrimaryDark,
    );
  }

  /// Returns secondary text color based on current theme
  static Color secondaryTextColor(BuildContext context) {
    return adaptiveColor(
      context: context,
      light: AppColors.textSecondaryLight,
      dark: AppColors.textSecondaryDark,
    );
  }

  /// Returns disabled color based on current theme
  static Color disabledColor(BuildContext context) {
    return adaptiveColor(
      context: context,
      light: AppColors.disabledLight,
      dark: AppColors.disabledDark,
    );
  }

  /// Returns error color based on current theme
  static Color errorColor(BuildContext context) {
    return adaptiveColor(
      context: context,
      light: AppColors.errorLight,
      dark: AppColors.errorDark,
    );
  }

  /// Returns success color based on current theme
  static Color successColor(BuildContext context) {
    return adaptiveColor(
      context: context,
      light: AppColors.successLight,
      dark: AppColors.successDark,
    );
  }

  /// Returns warning color based on current theme
  static Color warningColor(BuildContext context) {
    return adaptiveColor(
      context: context,
      light: AppColors.warningLight,
      dark: AppColors.warningDark,
    );
  }

  /// Returns info color based on current theme
  static Color infoColor(BuildContext context) {
    return adaptiveColor(
      context: context,
      light: AppColors.infoLight,
      dark: AppColors.infoDark,
    );
  }

  // ================ TEXT STYLE HELPERS ================ //

  /// Creates a text style with adaptive color based on theme
  static TextStyle adaptiveTextStyle({
    required BuildContext context,
    required TextStyle baseStyle,
    Color? lightColor,
    Color? darkColor,
  }) {
    final color = adaptiveColor(
      context: context,
      light: lightColor ?? primaryTextColor(context),
      dark: darkColor ?? primaryTextColor(context),
    );
    return baseStyle.copyWith(color: color);
  }

  /// Returns text theme from current context
  static TextTheme textTheme(BuildContext context) {
    return Theme.of(context).textTheme;
  }

  /// Returns color scheme from current context
  static ColorScheme colorScheme(BuildContext context) {
    return Theme.of(context).colorScheme;
  }

  // ================ PLATFORM & DEVICE HELPERS ================ //

  /// Checks if the app is in dark mode
  static bool isDarkMode(BuildContext context) {
    return _isDarkMode(context);
  }

  /// Checks if the device has a small screen
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  /// Checks if the device has a medium screen
  static bool isMediumScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1200;
  }

  /// Checks if the device has a large screen
  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  /// Returns appropriate padding based on screen size
  static EdgeInsets responsivePadding(BuildContext context) {
    if (isLargeScreen(context)) {
      return spacingLargeAll;
    } else if (isMediumScreen(context)) {
      return spacingMediumAll;
    } else {
      return spacingSmallAll;
    }
  }

  /// Returns appropriate font size based on screen size
  static double responsiveFontSize(BuildContext context, {required double baseSize}) {
    if (isLargeScreen(context)) {
      return baseSize * 1.2;
    } else if (isSmallScreen(context)) {
      return baseSize * 0.9;
    } else {
      return baseSize;
    }
  }

  // ================ SHADOW UTILITIES ================ //

  /// Returns a box shadow based on elevation and theme
  static List<BoxShadow> boxShadow({
    required BuildContext context,
    double elevation = 4.0,
    Color? shadowColor,
  }) {
    final color = shadowColor ??
        (isDarkMode(context) ? Colors.black54 : Colors.black26);

    return [
      BoxShadow(
        color: color,
        blurRadius: elevation,
        offset: const Offset(0, 2),
      ),
    ];
  }

  // ================ PRIVATE HELPERS ================ //

  static bool _isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}

/// Extension methods for easier access to theme utilities
extension ThemeUtilsExtension on BuildContext {
  // Color getters
  Color get textFieldBackgroundColor =>
      ThemeUtils.textFieldBackgroundColor(this);

  Color get textFieldPlaceholderColor =>
      ThemeUtils.textFieldPlaceholderColor(this);

  Color get cardColor => ThemeUtils.cardColor(this);

  Color get scaffoldBackgroundColor => ThemeUtils.scaffoldBackgroundColor(this);

  Color get primaryTextColor => ThemeUtils.primaryTextColor(this);

  Color get secondaryTextColor => ThemeUtils.secondaryTextColor(this);

  Color get disabledColor => ThemeUtils.disabledColor(this);

  Color get errorColor => ThemeUtils.errorColor(this);

  Color get successColor => ThemeUtils.successColor(this);

  Color get warningColor => ThemeUtils.warningColor(this);

  Color get infoColor => ThemeUtils.infoColor(this);

  // Layout getters
  bool get isDarkMode => ThemeUtils.isDarkMode(this);

  bool get isSmallScreen => ThemeUtils.isSmallScreen(this);

  bool get isMediumScreen => ThemeUtils.isMediumScreen(this);

  bool get isLargeScreen => ThemeUtils.isLargeScreen(this);

  EdgeInsets get responsivePadding => ThemeUtils.responsivePadding(this);

  // Theme getters
  TextTheme get textTheme => ThemeUtils.textTheme(this);

  ColorScheme get colorScheme => ThemeUtils.colorScheme(this);
}