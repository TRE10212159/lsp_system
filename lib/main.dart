import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/utils/loading_placeholder.dart';

/// アプリケーションのエントリーポイント
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: App()));
  // Web: 初回フレーム描画後に HTML のローディングプレースホルダーを削除
  WidgetsBinding.instance.addPostFrameCallback((_) {
    removeLoadingPlaceholder();
  });
}
