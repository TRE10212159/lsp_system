import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lsp_system/core/constants/routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// ページレイアウト
import 'package:lsp_system/shared/widgets/page_layout/page_layout.dart';

import 'package:lsp_system/core/providers/auth_provider.dart';

// ログイン
import 'package:lsp_system/pages/login_page.dart';
// ホーム
import 'package:lsp_system/pages/home_page.dart' deferred as home_page;
// 作業モデル管理
import 'package:lsp_system/pages/work_model_page.dart' deferred as work_model_page;
// 直近物量変動人時予測
import 'package:lsp_system/pages/workforce/forecast_register_page.dart' deferred as forecast_register_page;
import 'package:lsp_system/pages/workforce/forecast_night_page.dart' deferred as forecast_night_page;
import 'package:lsp_system/pages/workforce/forecast_fresh_page.dart' deferred as forecast_fresh_page;
// 稼働計画
import 'package:lsp_system/pages/attendance_plan_page.dart' deferred as attendance_plan_page;
// 作業割当
import 'package:lsp_system/pages/work_assignment_page.dart' deferred as work_assignment_page;
// 作業実績進捗管理
import 'package:lsp_system/pages/progress/personal_page.dart' deferred as progress_personal_page;
import 'package:lsp_system/pages/progress/manager_page.dart' deferred as progress_manager_page;
// 分析レポート
import 'package:lsp_system/pages/analysis/analysis_budget_page.dart' deferred as analysis_budget_page;
import 'package:lsp_system/pages/analysis/analysis_variance_page.dart' deferred as analysis_variance_page;
import 'package:lsp_system/pages/analysis/analysis_productivity_page.dart' deferred as analysis_productivity_page;
// 個人サービス
import 'package:lsp_system/pages/personal/plan_revision_page.dart' deferred as plan_revision_page;
import 'package:lsp_system/pages/personal/makeup_leave_page.dart' deferred as makeup_leave_page;
import 'package:lsp_system/pages/personal/annual_leave_page.dart' deferred as annual_leave_page;
import 'package:lsp_system/pages/personal/apply_job_page.dart' deferred as apply_job_page;

part 'app_router.g.dart';

/// Deferred ロード中はローディング表示、完了後に子を表示する
GoRoute _deferredBuilder(String path, Future<void> libraryFuture, Widget Function() buildChild) {
  return GoRoute(
    path: path,
    builder: (context, state) {
      return FutureBuilder<void>(
        future: libraryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) return buildChild();
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      );
    },
  );
}

/// 認証状態変更通知用のクラス
class AuthNotifier extends ChangeNotifier {
  final Ref _ref;
  ProviderSubscription? _subscription;

  AuthNotifier(this._ref) {
    _subscription = _ref.listen(authStateProvider, (_, __) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription?.close();
    super.dispose();
  }
}

/// ルーター設定プロバイダー
@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final notifier = AuthNotifier(ref);

  final router = GoRouter(
    initialLocation: Routes.login.value,
    refreshListenable: notifier,
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final isLoginPage = state.matchedLocation == Routes.login.value;

      return authState.when(
        data: (isLoggedIn) {
          if (!isLoggedIn && !isLoginPage) return Routes.login.value;
          if (isLoggedIn && isLoginPage) return Routes.home.value;
          return null;
        },
        loading: () {
          if (isLoginPage) return null;
          return null;
        },
        error: (_, __) => Routes.login.value,
      );
    },
    routes: [
      // Login
      GoRoute(path: Routes.login.value, builder: (context, state) => const LoginPage()),
      // Other
      ShellRoute(
        builder: (context, state, child) => PageLayout(child: child),
        routes: [
          // ホーム
          _deferredBuilder(Routes.home.value, home_page.loadLibrary(), () => home_page.HomePage()),
          // 作業モデル管理
          _deferredBuilder(
            Routes.workModel.value,
            work_model_page.loadLibrary(),
            () => work_model_page.WorkModelPage(),
          ),
          // 直近物量変動人時予測 - レジ人時予測
          _deferredBuilder(
            Routes.workforceForecastRegister.value,
            forecast_register_page.loadLibrary(),
            () => forecast_register_page.ForecastRegisterPage(),
          ),
          // 直近物量変動人時予測 - 夜間人時予測
          _deferredBuilder(
            Routes.workforceForecastNight.value,
            forecast_night_page.loadLibrary(),
            () => forecast_night_page.ForecastNightPage(),
          ),
          // 直近物量変動人時予測 - 生鮮製造人時予測
          _deferredBuilder(
            Routes.workforceForecastFreshManufacturing.value,
            forecast_fresh_page.loadLibrary(),
            () => forecast_fresh_page.ForecastFreshPage(),
          ),
          // 稼働計画
          _deferredBuilder(
            Routes.attendancePlan.value,
            attendance_plan_page.loadLibrary(),
            () => attendance_plan_page.AttendancePlanPage(),
          ),
          // 作業割当
          _deferredBuilder(
            Routes.workAssignment.value,
            work_assignment_page.loadLibrary(),
            () => work_assignment_page.WorkAssignmentPage(),
          ),
          // 作業実績進捗管理 - 個人作業実績管理
          _deferredBuilder(
            Routes.progressPersonal.value,
            progress_personal_page.loadLibrary(),
            () => progress_personal_page.ProgressPersonalPage(),
          ),
          // 作業実績進捗管理 - MGR作業進捗管理
          _deferredBuilder(
            Routes.progressManager.value,
            progress_manager_page.loadLibrary(),
            () => progress_manager_page.ProgressManagerPage(),
          ),
          // 分析レポート - 予算計画実績契約分析
          _deferredBuilder(
            Routes.analysisBudget.value,
            analysis_budget_page.loadLibrary(),
            () => analysis_budget_page.AnalysisBudgetPage(),
          ),
          // 分析レポート - 予算計画実績契約分析
          _deferredBuilder(
            Routes.analysisVariance.value,
            analysis_variance_page.loadLibrary(),
            () => analysis_variance_page.AnalysisVariancePage(),
          ),
          // 分析レポート - 必要人時と契約差異分析
          _deferredBuilder(
            Routes.analysisProductivity.value,
            analysis_productivity_page.loadLibrary(),
            () => analysis_productivity_page.AnalysisProductivityPage(),
          ),
          // 個人サービス - 個人計画修正
          _deferredBuilder(
            Routes.personalPlanRevision.value,
            plan_revision_page.loadLibrary(),
            () => plan_revision_page.PlanRevisionPage(),
          ),
          // 個人サービス - 希望休・希望時間申請
          _deferredBuilder(
            Routes.personalMakeUpLeave.value,
            makeup_leave_page.loadLibrary(),
            () => makeup_leave_page.MakeupLeavePage(),
          ),
          // 個人サービス - 有給・時間変更申請
          _deferredBuilder(
            Routes.personalAnnualLeave.value,
            annual_leave_page.loadLibrary(),
            () => annual_leave_page.AnnualLeavePage(),
          ),
          // 個人サービス - 応募
          _deferredBuilder(
            Routes.personalApplyJob.value,
            apply_job_page.loadLibrary(),
            () => apply_job_page.ApplyJobPage(),
          ),
        ],
      ),
    ],
  );

  ref.onDispose(notifier.dispose);

  return router;
}
