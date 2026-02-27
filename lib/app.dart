import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lsp_system/core/providers/auth_provider.dart';
import 'router/app_router.dart';
import 'shared/theme/app_theme.dart';
import 'shared/widgets/loading_indicator.dart';

/// アプリケーションのルートウィジェット
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final router = ref.watch(routerProvider);

    return authState.when(
      loading: () {
        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LoadingIndicator(),
                  const SizedBox(height: 16),
                  Text('読み込み中...', style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stack) {
        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('初期化エラー: $error', style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        );
      },
      data: (_) {
        return MaterialApp.router(
          title: 'LSP System',
          theme: AppTheme.light(),
          themeMode: ThemeMode.light,
          routerConfig: router,
        );
      },
    );
  }
}
