import 'package:flutter/material.dart';

/// アプリケーションテーマ設定
class AppTheme {
  /// ライトテーマ
  static ThemeData light() {
    ThemeData themeData = ThemeData(
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
      ),
      useMaterial3: true,
      hoverColor: Color(0x22000000),
      colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF21417B), brightness: Brightness.light),
    );

    TextTheme textTheme = themeData.textTheme.copyWith(
      displayLarge: themeData.textTheme.displayLarge?.copyWith(fontWeight: FontWeight.bold),
      displayMedium: themeData.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
      displaySmall: themeData.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
      headlineLarge: themeData.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
      headlineMedium: themeData.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
      headlineSmall: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
      titleLarge: themeData.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      titleMedium: themeData.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      titleSmall: themeData.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
      bodyLarge: themeData.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.normal),
      bodyMedium: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.normal),
      bodySmall: themeData.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.normal),
      labelLarge: themeData.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
      labelMedium: themeData.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
      labelSmall: themeData.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
    );

    IconThemeData iconTheme = themeData.iconTheme.copyWith(color: themeData.colorScheme.primary, size: 24);

    return themeData.copyWith(textTheme: textTheme, iconTheme: iconTheme);
    // return themeData;
  }
}
