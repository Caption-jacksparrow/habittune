import 'package:flutter/material.dart';

/// Theme configuration for the HabitTune app based on brand guidelines
class AppTheme {
  // Brand colors from guidelines
  static const Color deepPurple = Color(0xFF673AB7);
  static const Color vibrantBlue = Color(0xFF2196F3);
  static const Color darkGray = Color(0xFF212121);
  static const Color lightGray = Color(0xFFE0E0E0);
  static const Color white = Colors.white;

  /// Get the light theme for the app
  static ThemeData getLightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: deepPurple,
        primary: deepPurple,
        secondary: vibrantBlue,
        onPrimary: white,
        onSecondary: white,
        background: Colors.grey[50]!,
        surface: white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: deepPurple,
        foregroundColor: white,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: deepPurple,
          foregroundColor: white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: deepPurple,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: deepPurple,
          side: const BorderSide(color: deepPurple),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: deepPurple,
        foregroundColor: white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: deepPurple, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey[100],
        selectedColor: deepPurple.withOpacity(0.2),
        labelStyle: const TextStyle(color: darkGray),
        secondaryLabelStyle: const TextStyle(color: white),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: darkGray, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: darkGray, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(color: darkGray, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(color: darkGray, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: darkGray, fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(color: darkGray, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: darkGray, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: darkGray, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(color: darkGray, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: darkGray),
        bodyMedium: TextStyle(color: darkGray),
        bodySmall: TextStyle(color: Colors.grey[700]),
        labelLarge: TextStyle(color: darkGray, fontWeight: FontWeight.w500),
        labelMedium: TextStyle(color: darkGray),
        labelSmall: TextStyle(color: Colors.grey[700]),
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey[300],
        thickness: 1,
        space: 1,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: deepPurple,
        circularTrackColor: lightGray,
        linearTrackColor: lightGray,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return deepPurple;
          }
          return Colors.grey[400]!;
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return deepPurple;
          }
          return Colors.grey[400]!;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return deepPurple;
          }
          return Colors.grey[400]!;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return deepPurple.withOpacity(0.5);
          }
          return Colors.grey[300]!;
        }),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: white,
        selectedItemColor: deepPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: deepPurple,
        unselectedLabelColor: Colors.grey,
        indicatorColor: deepPurple,
      ),
    );
  }
}
