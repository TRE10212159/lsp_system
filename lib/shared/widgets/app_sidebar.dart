import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lsp_system/constants/base_states.dart';
import 'package:lsp_system/constants/dictionary.dart';
import 'package:lsp_system/constants/routes.dart';
import 'icons.dart';

class AppSidebar extends StatefulWidget {
  const AppSidebar({super.key});
  static final double expandedWidth = 280;
  static final double collapsedWidth = 68;

  @override
  State<AppSidebar> createState() => _AppSidebarState();
}

class _AppSidebarState extends State<AppSidebar> {
  bool collapsed = false;
  Set<String> expandedMenus = {};

  void setStates(VoidCallback callback) => mounted ? setState(callback) : null;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 0),
      width: collapsed ? AppSidebar.collapsedWidth : AppSidebar.expandedWidth,
      decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.transparent, width: 1))),
      child: Theme(
        data: Theme.of(context).copyWith(
          textTheme: TextTheme(titleLarge: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
          iconTheme: IconThemeData(color: Colors.white, size: 16.0),
          hoverColor: Color(0x22000000),
          listTileTheme: ListTileThemeData(
            selectedTileColor: const Color(0x11ffffff),
            textColor: Colors.white,
            selectedColor: Colors.white,
            horizontalTitleGap: 4,
          ),
        ),
        child: Builder(
          builder: (context) {
            return Drawer(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
                child: Column(children: [buildSidebarTitle(context), Expanded(child: buildMenu(context))]),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildSidebarTitle(BuildContext context) {
    if (collapsed) {
      return SizedBox(
        width: double.infinity,
        height: kToolbarHeight,
        child: Center(
          child: IconButton(icon: ChevronRightIcon(size: 16), onPressed: () => setStates(() => collapsed = false)),
        ),
      );
    }

    final title = Text(
      Dictionary.appName.t(),
      style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
    );
    final iconButton = IconButton(icon: ChevronLeftIcon(size: 16), onPressed: () => setStates(() => collapsed = true));
    return SizedBox(
      width: double.infinity,
      height: kToolbarHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(left: 0, right: 0, child: Center(child: title)),
          Positioned(right: 16, top: 0, bottom: 0, child: Center(child: iconButton)),
        ],
      ),
    );
  }

  Material buildMenu(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ホーム
          buildRouterLink(context, HouseIcon(), Routes.home),
          // 作業モデル管理
          buildRouterLink(context, CubesIcon(), Routes.workModel),
          // 直近物量変動人時予測
          buildExpandableItem(context, ChartLineIcon(), Routes.workforceForecast, [
            // レジ人時予測
            buildRouterLink(context, CalculatorIcon(), Routes.workforceForecastRegister),
            // 夜間人時予測
            buildRouterLink(context, MoonIcon(), Routes.workforceForecastNight),
            // 生鮮製造人時予測
            buildRouterLink(context, UtensilsIcon(), Routes.workforceForecastFreshManufacturing),
          ]),
          // 稼働計画
          buildRouterLink(context, CalendarDaysIcon(), Routes.operationPlan),
          // 作業割当
          buildRouterLink(context, ListUlIcon(), Routes.workAssignment),
          // 作業実績進捗管理
          buildExpandableItem(context, ChartBarIcon(), Routes.progress, [
            // 予算計画実績合同分析
            buildRouterLink(context, UserIcon(), Routes.progressPersonal),
            // MGR作業進捗管理
            buildRouterLink(context, UsersIcon(), Routes.progressManager),
          ]),
          // 分析レポート
          buildExpandableItem(context, FileLinesIcon(), Routes.analytics, [
            // 予算計画実績契約分析
            buildRouterLink(context, ChartBarIcon(), Routes.analyticsBudget),
            // 必要人時と契約差異分析
            buildRouterLink(context, ChartLineIcon(), Routes.analyticsVariance),
            // 人時生産性
            buildRouterLink(context, CalculatorIcon(), Routes.analyticsProductivity),
          ]),
          // 個人サービス
          buildExpandableItem(context, UserIcon(), Routes.personalServices, [
            // 個人計画修正
            buildRouterLink(context, PenToSquareIcon(), Routes.personalPlanRevision),
            // 希望休・希望時間申請
            buildRouterLink(context, CalendarCheckIcon(), Routes.personalLeaveRequest),
            // 有給・時間変更申請
            buildRouterLink(context, ClockIcon(), Routes.personalScheduleChange),
            // 応募
            buildRouterLink(context, BriefcaseIcon(), Routes.personalApplication),
          ]),
        ],
      ),
    );
  }

  Widget buildRouterLink(BuildContext context, Widget prefix, BaseOption option) {
    final isActive = GoRouterState.of(context).uri.toString() == option.value;

    final shape = Border(left: BorderSide(color: isActive ? Color(0xFF4caf50) : Colors.transparent, width: 4));

    void onTap() => context.go(option.value);

    if (collapsed) {
      return Tooltip(
        message: option.label,
        child: ListTile(selected: isActive, shape: shape, title: Center(child: prefix), onTap: onTap),
      );
    }
    return ListTile(leading: prefix, title: Text(option.label), selected: isActive, onTap: onTap, shape: shape);
  }

  Widget buildExpandableItem(BuildContext context, Widget prefix, BaseOption option, List<Widget> children) {
    Widget? child;
    Widget? menuItem;
    Widget? suffix;
    VoidCallback? onTap;
    if (!collapsed) {
      if (expandedMenus.contains(option.value)) {
        suffix = ChevronUpIcon(size: 12);
        onTap = () => setStates(() => expandedMenus.remove(option.value));
        ThemeData theme = Theme.of(context);
        ListTileThemeData listTileTheme = theme.listTileTheme.copyWith(contentPadding: EdgeInsets.only(left: 32));
        child = Container(
          decoration: BoxDecoration(color: const Color(0x22000000)),
          child: Theme(data: theme.copyWith(listTileTheme: listTileTheme), child: Column(children: children)),
        );
      } else {
        suffix = ChevronDownIcon(size: 12);
        onTap = () => setStates(() => expandedMenus.add(option.value));
        child = null;
      }
      menuItem = ListTile(leading: prefix, trailing: suffix, title: Text(option.value), onTap: onTap);
    } else {
      menuItem = Tooltip(message: option.value, child: ListTile(title: Center(child: prefix)));
    }
    return Column(children: [menuItem, if (child != null) child]);
  }
}
