import 'package:flutter/material.dart';

class ShadTheme {
  // Colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color foreground = Color(0xFF18181B);

  static const Color card = Color(0xFFFFFFFF);
  static const Color cardForeground = Color(0xFF18181B);

  static const Color popover = Color(0xFFFFFFFF);
  static const Color popoverForeground = Color(0xFF18181B);

  static const Color primary = Color(0xFF4A6741); // Keeping the mosque green
  static const Color primaryForeground = Color(0xFFFFFFFF);

  static const Color secondary = Color(0xFFF1F5F9);
  static const Color secondaryForeground = Color(0xFF18181B);

  static const Color muted = Color(0xFFF1F5F9);
  static const Color mutedForeground = Color(0xFF64748B);

  static const Color accent = Color(0xFFF1F5F9);
  static const Color accentForeground = Color(0xFF18181B);

  static const Color destructive = Color(0xFFEF4444);
  static const Color destructiveForeground = Color(0xFFFFFFFF);

  static const Color border = Color(0xFFE2E8F0);
  static const Color input = Color(0xFFE2E8F0);
  static const Color ring = Color(0xFF4A6741);

  // Radius
  static const double radius = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusSm = 8.0;

  // Animation
  static const Duration duration = Duration(milliseconds: 200);
  static const Curve curve = Curves.easeInOut;

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: card,
        error: destructive,
      ),
      scaffoldBackgroundColor: background,
      cardTheme: CardTheme(
        color: card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: const BorderSide(color: border),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return primary.withOpacity(0.5);
            }
            return primary;
          }),
          foregroundColor: WidgetStateProperty.all(primaryForeground),
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.all(primary),
          side: WidgetStateProperty.all(const BorderSide(color: border)),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(primary),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: background,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: ring, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: destructive),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: destructive, width: 2),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: foreground,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: foreground,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: foreground,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: foreground,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: foreground,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: mutedForeground,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: foreground,
        elevation: 0,
        centerTitle: false,
      ),
    );
  }

  // Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        surface: background,
        onSurface: foreground,
        primary: primary,
        onPrimary: primaryForeground,
        secondary: secondary,
        onSecondary: secondaryForeground,
        error: destructive,
        onError: destructiveForeground,
      ),
      scaffoldBackgroundColor: background,
      cardColor: card,
      popupMenuTheme: const PopupMenuThemeData(
        color: popover,
        textStyle: TextStyle(color: popoverForeground),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: input,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: ring, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: destructive),
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: foreground),
        bodyMedium: TextStyle(color: foreground),
        titleMedium: TextStyle(color: foreground),
      ),
    );
  }
}
