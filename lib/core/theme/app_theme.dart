import 'package:dwarka_app/core/theme/theme_utils.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  // Light theme ke liye getter - app mein use hoga
  static ThemeData get lightTheme => _buildLightTheme();

  // Dark theme ke liye getter - system theme follow karega
  static ThemeData get darkTheme => _buildDarkTheme();

  static ThemeData _buildLightTheme() {
    // ColorScheme automatically generate karta hai seed color se
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    );

    // Base text theme le rahe hain Material 2021 se
    final TextTheme baseTextTheme = Typography.material2021().black;
    final TextTheme textTheme = baseTextTheme.copyWith(
      // Display texts - bade headings ke liye
      displayLarge: baseTextTheme.displayLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryLight,
      ) ?? const TextStyle(),
      displayMedium: baseTextTheme.displayMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryLight,
      ) ?? const TextStyle(),

      // Headline texts - medium headings ke liye
      headlineLarge: baseTextTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryLight,
      ) ?? const TextStyle(),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryLight,
      ) ?? const TextStyle(),

      // Body texts - normal content ke liye
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(
        color: AppColors.textPrimaryLight,
      ) ?? const TextStyle(),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(
        color: AppColors.textSecondaryLight, // Secondary text thoda light
      ) ?? const TextStyle(),
    );

    // Complete theme data return karna
    return ThemeData(
      useMaterial3: true, // Material 3 features enable karo
      brightness: Brightness.light, // Light mode
      colorScheme: scheme, // Auto-generated color scheme
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundLight, // Background color
      cardColor: AppColors.cardBackgroundLight, // Card background
      textTheme: textTheme, // Custom text styles

      // Elevated buttons styling - primary color wale buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary, // Button ka background
          foregroundColor: Colors.white, // Text color
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), // Button padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusMedium), // Rounded corners
          ),
          // Disabled state handle karo - production ke liye important
          disabledBackgroundColor: Colors.grey.shade300,
          disabledForegroundColor: Colors.grey.shade500,
        ),
      ),

      // Outlined buttons - border wale buttons
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary, // Text color
          side: const BorderSide(color: AppColors.primary), // Border color
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusMedium),
          ),
        ),
      ),

      // Text buttons - simple text wale buttons
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary, // Text color
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),

      // Input fields styling - TextFormField, TextField ke liye
      inputDecorationTheme: InputDecorationTheme(
        filled: true, // Background fill karo
        fillColor: AppColors.textFieldBackgroundLight, // Fill color
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), // Inner padding
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusMedium),
          borderSide: BorderSide.none, // Default border nahi dikhega
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusMedium),
          borderSide: BorderSide.none, // Enabled state mein border nahi
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.primary, width: 2), // Focus pe primary color
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.errorLight), // Error state
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.errorLight, width: 2), // Focused error
        ),
        hintStyle: TextStyle(color: AppColors.textFieldPlaceholderLight), // Hint text color
        labelStyle: TextStyle(color: AppColors.textSecondaryLight), // Label color
        errorStyle: TextStyle(color: AppColors.errorLight), // Error text color
        floatingLabelStyle: const TextStyle(color: AppColors.primary), // Floating label color
      ),

      // Card widget styling
      cardTheme: CardThemeData(
        color: AppColors.cardBackgroundLight, // Card background
        elevation: ThemeUtils.elevationLow, // Shadow intensity
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusLarge), // Rounded corners
        ),
        margin: ThemeUtils.spacingSmallAll, // Card ke bahar ka spacing
      ),

      // AppBar styling - top navigation bar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.scaffoldBackgroundLight, // Background color
        foregroundColor: AppColors.textPrimaryLight, // Text/icons color
        elevation: ThemeUtils.elevationNone, // Shadow remove karo
        surfaceTintColor: Colors.transparent, // Material 3 - tint color transparent
        titleTextStyle: textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold, // Title bold karo
        ),
      ),

      // Bottom Navigation Bar styling
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.cardBackgroundLight, // Background
        selectedItemColor: AppColors.primary, // Selected item color
        unselectedItemColor: AppColors.textSecondaryLight, // Unselected item color
        elevation: 4.0, // Thoda shadow
        type: BottomNavigationBarType.fixed, // Fixed type - labels always visible
      ),

      // Divider styling - content separate karne ke liye
      dividerTheme: DividerThemeData(
        color: AppColors.border.withOpacity(0.5), // Border color with opacity
        thickness: 1, // Line thickness
        space: 1, // Spacing around divider
      ),

      // Navigation Bar (Material 3) - for newer navigation patterns
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.cardBackgroundLight, // Background
        indicatorColor: AppColors.primary.withOpacity(0.2), // Selected indicator
        labelTextStyle: WidgetStateProperty.all(
          textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500), // Label style
        ),
      ),

      // Floating Action Button styling
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary, // Background color
        foregroundColor: Colors.white, // Icon color
      ),

      // SnackBar styling - notifications ke liye
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating, // Floating type
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusMedium), // Rounded corners
        ),
        backgroundColor: AppColors.cardBackgroundLight, // Light theme background
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: AppColors.textPrimaryLight), // Text style
      ),

      // Progress indicators - loading states ke liye
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary, // Progress color
        circularTrackColor: AppColors.textFieldBackgroundLight, // Track color
      ),

      // Chip widget styling - tags, filters ke liye
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.textFieldBackgroundLight, // Background
        selectedColor: AppColors.primary.withOpacity(0.2), // Selected state
        labelStyle: textTheme.bodyMedium ?? const TextStyle(), // Label style
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusCircular), // Circular corners
        ),
      ),

      // Bottom Sheet styling - modal dialogs ke liye
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.cardBackgroundLight, // Background
        surfaceTintColor: Colors.transparent, // No tint
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ThemeUtils.borderRadiusExtraLarge), // Top rounded corners
          ),
        ),
      ),

      // Tab Bar styling - tabbed interfaces ke liye
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primary, // Selected tab color
        unselectedLabelColor: AppColors.textSecondaryLight, // Unselected tab color
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusCircular),
          color: AppColors.primary.withOpacity(0.1), // Indicator background
        ),
      ),

      // Platform-specific density - adaptive UI
      visualDensity: VisualDensity.adaptivePlatformDensity,

      // Additional production-ready settings
      splashFactory: InkRipple.splashFactory, // Modern ripple effect
      highlightColor: AppColors.primary.withOpacity(0.1), // Tap highlight color
    );
  }

  static ThemeData _buildDarkTheme() {
    // Dark theme ke liye color scheme
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    );

    // Dark theme ke liye white base text
    final TextTheme baseTextTheme = Typography.material2021().white;
    final TextTheme textTheme = baseTextTheme.copyWith(
      // Display texts - dark theme versions
      displayLarge: baseTextTheme.displayLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryDark,
      ) ?? const TextStyle(),
      displayMedium: baseTextTheme.displayMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryDark,
      ) ?? const TextStyle(),

      // Headline texts
      headlineLarge: baseTextTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryDark,
      ) ?? const TextStyle(),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryDark,
      ) ?? const TextStyle(),

      // Body texts
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(
        color: AppColors.textPrimaryDark,
      ) ?? const TextStyle(),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(
        color: AppColors.textSecondaryDark,
      ) ?? const TextStyle(),
    );

    // Dark theme data - light theme ke similar but dark colors
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundDark,
      cardColor: AppColors.cardBackgroundDark,
      textTheme: textTheme,

      // Elevated buttons - dark theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusMedium),
          ),
          // Disabled state for dark theme
          disabledBackgroundColor: Colors.grey.shade700,
          disabledForegroundColor: Colors.grey.shade400,
        ),
      ),

      // Outlined buttons - primaryLight use karo for better visibility
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryLight, // Brighter color for dark theme
          side: const BorderSide(color: AppColors.primaryLight),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusMedium),
          ),
        ),
      ),

      // Text buttons
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLight, // Brighter color
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),

      // Input fields - dark theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.textFieldBackgroundDark, // Dark background
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusMedium),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusMedium),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2), // Brighter focus
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.errorDark), // Dark error color
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.errorDark, width: 2),
        ),
        hintStyle: TextStyle(color: AppColors.textFieldPlaceholderDark), // Dark hint
        labelStyle: TextStyle(color: AppColors.textSecondaryDark), // Dark label
        errorStyle: TextStyle(color: AppColors.errorDark), // Dark error text
        floatingLabelStyle: const TextStyle(color: AppColors.primaryLight), // Brighter floating label
      ),

      // Cards - dark theme
      cardTheme: CardThemeData(
        color: AppColors.cardBackgroundDark,
        elevation: ThemeUtils.elevationLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusLarge),
        ),
        margin: ThemeUtils.spacingSmallAll,
      ),

      // AppBar - dark
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.scaffoldBackgroundDark,
        foregroundColor: AppColors.textPrimaryDark,
        elevation: ThemeUtils.elevationNone,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),

      // Bottom Navigation - dark
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.cardBackgroundDark,
        selectedItemColor: AppColors.primaryLight, // Brighter selected color
        unselectedItemColor: AppColors.textSecondaryDark,
        elevation: 4.0,
        type: BottomNavigationBarType.fixed,
      ),

      // Divider - dark theme with subtle color
      dividerTheme: DividerThemeData(
        color: Colors.white.withOpacity(0.1), // Very subtle white
        thickness: 1,
        space: 1,
      ),

      // Navigation Bar - dark
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.cardBackgroundDark,
        indicatorColor: AppColors.primaryLight.withOpacity(0.2), // Brighter indicator
        labelTextStyle: WidgetStateProperty.all(
          textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),

      // FAB - dark (same as light for consistency)
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),

      // SnackBar - dark theme
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusMedium),
        ),
        backgroundColor: AppColors.cardBackgroundDark, // Dark background
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: AppColors.textPrimaryDark), // Dark text
      ),

      // Progress indicators - dark
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryLight, // Brighter progress
        circularTrackColor: AppColors.textFieldBackgroundDark, // Dark track
      ),

      // Chips - dark theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.textFieldBackgroundDark, // Dark background
        selectedColor: AppColors.primaryLight.withOpacity(0.2), // Brighter selection
        labelStyle: textTheme.bodyMedium ?? const TextStyle(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusCircular),
        ),
      ),

      // Bottom Sheet - dark
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.cardBackgroundDark,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ThemeUtils.borderRadiusExtraLarge),
          ),
        ),
      ),

      // Tab Bar - dark theme
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primaryLight, // Brighter selected tab
        unselectedLabelColor: AppColors.textSecondaryDark,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(ThemeUtils.borderRadiusCircular),
          color: AppColors.primaryLight.withOpacity(0.1), // Brighter indicator
        ),
      ),

      // Platform-specific density
      visualDensity: VisualDensity.adaptivePlatformDensity,

      // Additional dark theme settings
      splashFactory: InkRipple.splashFactory,
      highlightColor: AppColors.primaryLight.withOpacity(0.1), // Brighter highlight
    );
  }
}