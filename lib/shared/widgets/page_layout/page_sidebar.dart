import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lsp_system/core/constants/base_states.dart';
import 'package:lsp_system/core/constants/dictionary.dart';
import 'package:lsp_system/core/constants/routes.dart';
import '../icons.dart';

/// アプリケーションのメインサイドバーウィジェット。
///
/// ナビゲーションメニューを表示し、展開/折りたたみ可能。
/// ルートリンクと展開可能なサブメニューをサポートする。

/// サイドバーの状態を管理する StatefulWidget。
///
/// [expandedWidth] / [collapsedWidth] で幅を切り替え、
/// メニュー項目の展開状態も保持する。
class PageSidebar extends StatefulWidget {
  const PageSidebar({super.key});

  /// サイドバーを展開したときの幅（ピクセル）。
  static final double expandedWidth = 280;

  /// サイドバーを折りたたんだときの幅（ピクセル）。
  static final double collapsedWidth = 68;

  @override
  State<PageSidebar> createState() => _PageSidebarState();
}

/// [PageSidebar] の内部状態を保持する State クラス。
class _PageSidebarState extends State<PageSidebar> {
  /// サイドバーが折りたたみ状態かどうか。true のとき幅は [PageSidebar.collapsedWidth]。
  bool collapsed = false;

  /// 現在展開されているメニューのルートパス（value）の集合。
  /// 例: ['/workforce-forecast', '/progress']
  Set<String> expandedMenus = {};

  /// [mounted] が true のときだけ [setState] を実行する安全なラッパー。
  /// 非同期処理後の更新でウィジェット破棄後の setState を防ぐ。
  void setStates(VoidCallback callback) => mounted ? setState(callback) : null;

  @override
  Widget build(BuildContext context) {
    // 折りたたみ状態に応じて幅が変わるコンテナ
    // collapsed が true のときは [collapsedWidth]、false のときは [expandedWidth] を使用
    return AnimatedContainer(
      duration: const Duration(milliseconds: 15),
      width: collapsed ? PageSidebar.collapsedWidth : PageSidebar.expandedWidth,
      decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.transparent, width: 1))),
      child: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.white, size: 16.0),
          listTileTheme: const ListTileThemeData(
            selectedTileColor: Color(0x11ffffff),
            shape: Border(left: BorderSide(color: Colors.transparent, width: 4)),
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

  /// サイドバー上部のタイトル領域を構築する。
  ///
  /// 折りたたみ時は右矢印ボタンのみ表示し、タップで展開。
  /// 展開時はアプリ名と左矢印ボタンを表示し、タップで折りたたみ。
  Widget buildSidebarTitle(BuildContext context) {
    // サイドバーが折りたたみ状態の場合：右矢印ボタンのみ表示し、タップで展開する
    if (collapsed) {
      return SizedBox(
        width: double.infinity,
        height: kToolbarHeight,
        child: Center(
          child: IconButton(icon: ChevronRightIcon(size: 16), onPressed: () => setStates(() => collapsed = false)),
        ),
      );
    }

    // サイドバーが展開状態の場合：アプリ名を中央に表示し、右端に左矢印ボタンで折りたたみ可能
    final title = Text(
      Dictionary.appName.t(),
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
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

  /// サイドバー内のメニューリスト全体を構築する。
  ///
  /// 単一リンク（[buildRouterLink]）と展開可能項目（[buildExpandableItem]）を並べる。
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
          buildRouterLink(context, CalendarDaysIcon(), Routes.attendancePlan),
          // 作業割当
          buildRouterLink(context, ListUlIcon(), Routes.workAssignment),
          // 作業実績進捗管理
          buildExpandableItem(context, ChartBarIcon(), Routes.progress, [
            // 個人作業実績管理
            buildRouterLink(context, UserIcon(), Routes.progressPersonal),
            // MGR作業進捗管理
            buildRouterLink(context, UsersIcon(), Routes.progressManager),
          ]),
          // 分析レポート
          buildExpandableItem(context, FileLinesIcon(), Routes.analysis, [
            // 予算計画実績契約分析
            buildRouterLink(context, ChartBarIcon(), Routes.analysisBudget),
            // 必要人時と契約差異分析
            buildRouterLink(context, ChartLineIcon(), Routes.analysisVariance),
            // 人時生産性
            buildRouterLink(context, CalculatorIcon(), Routes.analysisProductivity),
          ]),
          // 個人サービス
          buildExpandableItem(context, UserIcon(), Routes.personalServices, [
            // 個人計画修正
            buildRouterLink(context, PenToSquareIcon(), Routes.personalPlanRevision),
            // 希望休・希望時間申請
            buildRouterLink(context, CalendarCheckIcon(), Routes.personalMakeUpLeave),
            // 有給・時間変更申請
            buildRouterLink(context, ClockIcon(), Routes.personalAnnualLeave),
            // 応募
            buildRouterLink(context, BriefcaseIcon(), Routes.personalApplyJob),
          ]),
        ],
      ),
    );
  }

  /// ルートへ遷移する単一メニュー項目を構築する。
  ///
  /// [prefix] は先頭のアイコン等、[option] はルート情報（value / label）。
  /// 現在の URI が [option.value] と一致するとき選択状態（左緑ボーダー）で表示する。
  /// 折りたたみ時はアイコンのみ表示し、[Tooltip] でラベルを表示。
  Widget buildRouterLink(BuildContext context, Widget prefix, BaseOption option) {
    final isActive = GoRouterState.of(context).uri.toString() == option.value;

    final shape = Border(left: BorderSide(color: isActive ? Color(0xFF4caf50) : Colors.transparent, width: 4));

    void onTap() => context.go(option.value);

    // 折りたたみ時：アイコンのみ中央表示し、ホバーで [Tooltip] にラベルを表示
    if (collapsed) {
      return Tooltip(
        message: option.label,
        child: ListTile(selected: isActive, shape: shape, title: Center(child: prefix), onTap: onTap),
      );
    }

    // 展開時：先頭にアイコン、タイトルにラベルを表示する通常の [ListTile]
    final title = Text(option.label, softWrap: false, overflow: TextOverflow.ellipsis, style: TextStyle());

    return ListTile(leading: prefix, title: title, selected: isActive, onTap: onTap, shape: shape);
  }

  /// 展開/折りたたみ可能なメニュー項目を構築する。
  ///
  /// [prefix] は先頭アイコン、[option] は親メニューのルート情報。
  /// [children] は展開時に表示する子メニューウィジェットのリスト。
  /// 展開時は [expandedMenus] に [option.value] が含まれ、子を表示し上矢印で閉じる。
  /// 折りたたみ時は親項目のみ表示し、[Tooltip] でラベルを表示（子は非表示）。
  Widget buildExpandableItem(BuildContext context, Widget prefix, BaseOption option, List<Widget> children) {
    Widget? child;
    Widget? menuItem;
    Widget? suffix;
    VoidCallback? onTap;

    // サイドバーが展開状態のときの分岐
    if (!collapsed) {
      // このメニューが展開中：上矢印表示、タップで閉じる、子項目エリアを表示
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
        // このメニューが閉じている：下矢印表示、タップで展開、子項目は非表示
        suffix = ChevronDownIcon(size: 12);
        onTap = () => setStates(() => expandedMenus.add(option.value));
        child = null;
      }
      menuItem = ListTile(leading: prefix, trailing: suffix, title: Text(option.label), onTap: onTap);
    } else {
      // サイドバーが折りたたみ状態：親項目のみアイコン中央表示、[Tooltip] でラベル、展開/子は非表示
      menuItem = Tooltip(message: option.label, child: ListTile(title: Center(child: prefix)));
    }
    return Column(children: [menuItem, if (child != null) child]);
  }
}
