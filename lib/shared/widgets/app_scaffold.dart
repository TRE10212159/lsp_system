import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lsp_system/constants/routes.dart';
import '../../features/auth/providers/auth_provider.dart';
import 'app_sidebar.dart';

/// アプリケーションの共通スキャフォールド
class AppScaffold extends ConsumerStatefulWidget {
  /// 表示する子ウィジェット
  final Widget child;

  const AppScaffold({super.key, required this.child});

  @override
  ConsumerState<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends ConsumerState<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.toString();
    final pageTitle = Routes.getRouteName(currentLocation);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(
        children: [
          AppSidebar(),
          Expanded(
            child: Column(
              children: [
                /// AppBar（右側のみ）
                Material(
                  elevation: 4,
                  child: Container(
                    height: kToolbarHeight,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
                    child: Row(
                      children: [
                        Text(pageTitle, style: Theme.of(context).textTheme.titleLarge),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(_getCurrentDate(), style: Theme.of(context).textTheme.bodyMedium),
                        ),
                        IconButton(
                          icon: const Icon(Icons.account_circle),
                          tooltip: 'ユーザー情報',
                          onPressed: () {
                            _showUserMenu(context, ref);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(child: widget.child),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 現在の日付を取得
  String _getCurrentDate() {
    final now = DateTime.now();
    final weekdays = ['月', '火', '水', '木', '金', '土', '日'];
    final weekday = weekdays[now.weekday - 1];
    return '${now.year}年${now.month}月${now.day}日($weekday)';
  }

  /// ユーザーメニューを表示
  void _showUserMenu(BuildContext context, WidgetRef ref) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(MediaQuery.of(context).size.width, kToolbarHeight, 0, 0),
      items: [
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('ログアウト'),
            onTap: () async {
              Navigator.of(context).pop();
              await ref.read(authStateProvider.notifier).logout();
              if (context.mounted) context.go(Routes.login.value);
            },
          ),
        ),
      ],
    );
  }
}
