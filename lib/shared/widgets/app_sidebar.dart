import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/route_paths.dart';

/// アプリケーションのサイドバーナビゲーション
class AppSidebar extends StatefulWidget {
  const AppSidebar({super.key});

  @override
  State<AppSidebar> createState() => _AppSidebarState();
}

class _AppSidebarState extends State<AppSidebar> {
  String? _expandedMenu;

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.toString();
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    final sidebarContent = Column(
      children: [
        /// ヘッダー
        Container(
          width: double.infinity,
          height: kToolbarHeight,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          color: Theme.of(context).colorScheme.primary,
          alignment: Alignment.centerLeft,
          child: Text(
            'LSPシステム',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildMenuItem(
                context,
                icon: Icons.home,
                title: 'ホーム',
                path: RoutePaths.home,
                currentLocation: currentLocation,
              ),
              _buildMenuItem(
                context,
                icon: Icons.settings,
                title: '作業モデル管理',
                path: RoutePaths.workModel,
                currentLocation: currentLocation,
              ),
              _buildMenuItem(
                context,
                icon: Icons.analytics,
                title: '必要人時予測',
                path: RoutePaths.workforceForecast,
                currentLocation: currentLocation,
              ),
              _buildMenuItem(
                context,
                icon: Icons.calendar_today,
                title: '稼働計画',
                path: RoutePaths.operationPlan,
                currentLocation: currentLocation,
              ),
              _buildMenuItem(
                context,
                icon: Icons.assignment,
                title: '作業割当',
                path: RoutePaths.workAssignment,
                currentLocation: currentLocation,
              ),
              _buildExpandableMenuItem(
                context,
                icon: Icons.trending_up,
                title: '作業実績進捗管理',
                menuKey: 'progress',
                currentLocation: currentLocation,
                children: [
                  _buildSubMenuItem(
                    context,
                    title: '個人作業実績管理',
                    path: RoutePaths.progressPersonal,
                    currentLocation: currentLocation,
                  ),
                  _buildSubMenuItem(
                    context,
                    title: 'MGR作業進捗管理',
                    path: RoutePaths.progressManager,
                    currentLocation: currentLocation,
                  ),
                  _buildSubMenuItem(
                    context,
                    title: '作業完了率',
                    path: RoutePaths.progressCompletionRate,
                    currentLocation: currentLocation,
                  ),
                ],
              ),
              _buildExpandableMenuItem(
                context,
                icon: Icons.bar_chart,
                title: '分析レポート',
                menuKey: 'analytics',
                currentLocation: currentLocation,
                children: [
                  _buildSubMenuItem(
                    context,
                    title: '予算計画実績契約分析',
                    path: RoutePaths.analyticsBudget,
                    currentLocation: currentLocation,
                  ),
                  _buildSubMenuItem(
                    context,
                    title: '必要人時と契約差異分析',
                    path: RoutePaths.analyticsVariance,
                    currentLocation: currentLocation,
                  ),
                  _buildSubMenuItem(
                    context,
                    title: '人時生産性',
                    path: RoutePaths.analyticsProductivity,
                    currentLocation: currentLocation,
                  ),
                ],
              ),
              _buildExpandableMenuItem(
                context,
                icon: Icons.person,
                title: 'デジタル個人サービス',
                menuKey: 'personal',
                currentLocation: currentLocation,
                children: [
                  _buildSubMenuItem(
                    context,
                    title: '個人計画修正',
                    path: RoutePaths.personalPlanRevision,
                    currentLocation: currentLocation,
                  ),
                  _buildSubMenuItem(
                    context,
                    title: '希望休みや希望時間申請',
                    path: RoutePaths.personalLeaveRequest,
                    currentLocation: currentLocation,
                  ),
                  _buildSubMenuItem(
                    context,
                    title: '有給・時間変更申請',
                    path: RoutePaths.personalScheduleChange,
                    currentLocation: currentLocation,
                  ),
                  _buildSubMenuItem(
                    context,
                    title: '応募',
                    path: RoutePaths.personalApplication,
                    currentLocation: currentLocation,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    /// デスクトップ: Materialウィジェット
    if (isDesktop) {
      return Material(
        color: Theme.of(context).colorScheme.surface,
        child: sidebarContent,
      );
    }

    /// モバイル: Drawerウィジェット
    return Drawer(child: sidebarContent);
  }

  /// メニューアイテムを構築
  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String path,
    required String currentLocation,
  }) {
    final isSelected = currentLocation == path;

    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: isSelected,
      onTap: () {
        context.go(path);
        if (Scaffold.of(context).isDrawerOpen) {
          Navigator.of(context).pop();
        }
      },
    );
  }

  /// 展開可能なメニューアイテムを構築
  Widget _buildExpandableMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String menuKey,
    required String currentLocation,
    required List<Widget> children,
  }) {
    final isExpanded = _expandedMenu == menuKey;

    return Column(
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
          onTap: () {
            setState(() {
              _expandedMenu = isExpanded ? null : menuKey;
            });
          },
        ),
        if (isExpanded) ...children,
      ],
    );
  }

  /// サブメニューアイテムを構築
  Widget _buildSubMenuItem(
    BuildContext context, {
    required String title,
    required String path,
    required String currentLocation,
  }) {
    final isSelected = currentLocation == path;

    return ListTile(
      contentPadding: const EdgeInsets.only(left: 72, right: 16),
      title: Text(title),
      selected: isSelected,
      onTap: () {
        context.go(path);
        if (Scaffold.of(context).isDrawerOpen) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
