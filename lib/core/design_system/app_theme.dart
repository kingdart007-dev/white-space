import 'package:flutter/material.dart';

abstract final class AppSpacing {
  static const double x1 = 4;
  static const double x2 = 8;
  static const double x3 = 12;
  static const double x4 = 16;
  static const double x6 = 24;
  static const double x8 = 32;
  static const double x12 = 48;
}

abstract final class AppRadius {
  static const double small = 8;
  static const double medium = 12;
  static const double large = 16;
  static const double extraLarge = 24;
  static const double pill = 999;
}

abstract final class AppPalette {
  static const Color lightCanvas = Color(0xFFF8F8F6);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF191918);
  static const Color lightMuted = Color(0xFF686864);
  static const Color lightBorder = Color(0xFFE7E7E2);

  static const Color darkCanvas = Color(0xFF111110);
  static const Color darkSurface = Color(0xFF1B1B19);
  static const Color darkText = Color(0xFFF4F4F0);
  static const Color darkMuted = Color(0xFFB1B1AA);
  static const Color darkBorder = Color(0xFF343430);
}

abstract final class AppTheme {
  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final canvas = isDark ? AppPalette.darkCanvas : AppPalette.lightCanvas;
    final surface = isDark ? AppPalette.darkSurface : AppPalette.lightSurface;
    final text = isDark ? AppPalette.darkText : AppPalette.lightText;
    final muted = isDark ? AppPalette.darkMuted : AppPalette.lightMuted;
    final border = isDark ? AppPalette.darkBorder : AppPalette.lightBorder;

    final scheme = ColorScheme.fromSeed(
      seedColor: text,
      brightness: brightness,
      surface: surface,
      primary: text,
      onPrimary: isDark ? AppPalette.darkCanvas : AppPalette.lightSurface,
      secondary: muted,
      onSurface: text,
      outline: border,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: canvas,
      canvasColor: canvas,
      dividerColor: border,
      splashFactory: InkSparkle.splashFactory,
      textTheme: Typography.material2021().black
          .apply(bodyColor: text, displayColor: text)
          .copyWith(
            bodyMedium: TextStyle(fontSize: 14, height: 1.5, color: text),
            bodySmall: TextStyle(fontSize: 12, height: 1.45, color: muted),
            titleMedium: TextStyle(
              fontSize: 16,
              height: 1.35,
              fontWeight: FontWeight.w600,
              color: text,
            ),
            titleLarge: TextStyle(
              fontSize: 20,
              height: 1.3,
              fontWeight: FontWeight.w600,
              color: text,
            ),
            headlineMedium: TextStyle(
              fontSize: 28,
              height: 1.15,
              letterSpacing: -0.8,
              fontWeight: FontWeight.w600,
              color: text,
            ),
          ),
      appBarTheme: AppBarTheme(
        backgroundColor: canvas,
        foregroundColor: text,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.extraLarge),
          side: BorderSide(color: border),
        ),
      ),
      dividerTheme: DividerThemeData(color: border, thickness: 1, space: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: BorderSide(color: text, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.x4,
          vertical: AppSpacing.x3,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(48, 48),
          side: BorderSide(color: border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
        ),
      ),
      visualDensity: VisualDensity.standard,
    );
  }
}
