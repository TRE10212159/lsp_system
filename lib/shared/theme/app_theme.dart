import 'package:flutter/material.dart';

/// アプリケーションテーマ設定
class AppTheme {
  /// ライトテーマ
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF21417B), brightness: Brightness.light),
      // appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      // cardTheme: CardThemeData(elevation: 2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    );
  }
}
