import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../constants/route_paths.dart';
import 'app_sidebar.dart';

/// アプリケーションの共通スキャフォールド
class AppScaffold extends ConsumerWidget {
  /// 表示する子ウィジェット
  final Widget child;

  const AppScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = MediaQuery.of(context).size.width >= 1024;
    final currentLocation = GoRouterState.of(context).uri.toString();
    final pageTitle = _getPageTitle(currentLocation);

    if (isDesktop) {
      /// デスクトップレイアウト
      return Scaffold(
        body: Row(
          children: [
            /// 左側サイドバー（全高）
            Container(
              width: 280,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                ),
              ),
              child: const AppSidebar(),
            ),

            /// 右側コンテンツエリア
            Expanded(
              child: Column(
                children: [
                  /// AppBar（右側のみ）
                  Material(
                    elevation: 4,
                    child: Container(
                      height: kToolbarHeight,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: Row(
                        children: [
                          Text(
                            pageTitle,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              _getCurrentDate(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
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

                  /// メインコンテンツ
                  Expanded(child: child),
                ],
              ),
            ),
          ],
        ),
      );
    }

    /// モバイルレイアウト
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Text(
                _getCurrentDate(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
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
      drawer: const AppSidebar(),
      body: child,
    );
  }

  /// 現在のルートに基づいてページタイトルを取得
  String _getPageTitle(String location) {
    if (location == RoutePaths.home) return 'ホーム';
    if (location == RoutePaths.workforceForecast) return '必要人時予測';
    if (location == RoutePaths.operationPlan) return '稼働計画';
    if (location == RoutePaths.workAssignment) return '作業割当';
    if (location == RoutePaths.workModel) return '作業モデル管理';
    if (location == RoutePaths.progressPersonal) return '個人作業実績管理';
    if (location == RoutePaths.progressManager) return 'MGR作業進捗管理';
    if (location == RoutePaths.progressCompletionRate) return '作業完了率';
    if (location == RoutePaths.analyticsBudget) return '予算計画実績契約分析';
    if (location == RoutePaths.analyticsVariance) return '必要人時と契約差異分析';
    if (location == RoutePaths.analyticsProductivity) return '人時生産性';
    if (location == RoutePaths.personalPlanRevision) return '個人計画修正';
    if (location == RoutePaths.personalLeaveRequest) return '希望休みや希望時間申請';
    if (location == RoutePaths.personalScheduleChange) return '有給・時間変更申請';
    if (location == RoutePaths.personalApplication) return '応募';
    return 'LSPシステム';
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
      position: RelativeRect.fromLTRB(
        MediaQuery.of(context).size.width,
        kToolbarHeight,
        0,
        0,
      ),
      items: [
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('ログアウト'),
            onTap: () async {
              Navigator.of(context).pop();
              await ref.read(authStateProvider.notifier).logout();
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ),
      ],
    );
  }
}
