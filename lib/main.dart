import 'package:day/day.dart';
import 'package:lsp_system/core/constants/ja_locale.dart';
import 'package:lsp_system/core/utils/initialization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

/// アプリケーションのエントリーポイント
void main() {
  Day.locale = jaLocale;

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: App()));

  // Web: 初回フレーム描画後に HTML のローディングプレースホルダーを削除
  WidgetsBinding.instance.addPostFrameCallback((_) => removeLoadingPlaceholder());
}
