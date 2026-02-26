import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lsp_system/constants/routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../features/auth/providers/auth_provider.dart';
import '../features/auth/presentation/login_page.dart';
import '../features/home/presentation/home_page.dart';
import '../shared/widgets/app_scaffold.dart';
// 初回表示を軽くするため、以下は deferred で読み込む
import '../features/workforce_planning/presentation/workforce_forecast_register_page.dart'
    deferred as WorkforceForecastRegister;
import '../features/workforce_planning/presentation/workforce_forecast_night_page.dart'
    deferred as WorkforceForecastNight;
import '../features/workforce_planning/presentation/workforce_forecast_fresh_manufacturing_page.dart'
    deferred as WorkforceForecastFreshManufacturing;
import '../features/workforce_planning/presentation/operation_plan_page.dart' deferred as OperationPlan;
import '../features/workforce_planning/presentation/work_assignment_page.dart' deferred as WorkAssignment;
import '../features/work_model/presentation/work_model_page.dart' deferred as WorkModel;
import '../features/progress/presentation/progress_personal_page.dart' deferred as ProgressPersonal;
import '../features/progress/presentation/progress_manager_page.dart' deferred as ProgressManager;
import '../features/analytics/presentation/analytics_budget_page.dart' deferred as AnalyticsBudget;
import '../features/analytics/presentation/analytics_variance_page.dart' deferred as AnalyticsVariance;
import '../features/analytics/presentation/analytics_productivity_page.dart' deferred as AnalyticsProductivity;
import '../features/personal/presentation/personal_plan_revision_page.dart' deferred as PersonalPlanRevision;
import '../features/personal/presentation/personal_leave_request_page.dart' deferred as PersonalLeaveRequest;
import '../features/personal/presentation/personal_schedule_change_page.dart' deferred as PersonalScheduleChange;
import '../features/personal/presentation/personal_application_page.dart' deferred as PersonalApplication;

part 'app_router.g.dart';

/// Deferred ロード中はローディング表示、完了後に子を表示する
Widget _deferredBuilder(Future<void> libraryFuture, Widget Function() buildChild) {
  return FutureBuilder<void>(
    future: libraryFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) return buildChild();
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
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
        builder: (context, state, child) => AppScaffold(child: child),
        routes: [
          GoRoute(path: Routes.home.value, builder: (context, state) => const HomePage()),
          GoRoute(
            path: Routes.workforceForecastRegister.value,
            builder:
                (context, state) => _deferredBuilder(
                  WorkforceForecastRegister.loadLibrary(),
                  () => WorkforceForecastRegister.WorkforceForecastRegisterPage(),
                ),
          ),
          GoRoute(
            path: Routes.workforceForecastNight.value,
            builder:
                (context, state) => _deferredBuilder(
                  WorkforceForecastNight.loadLibrary(),
                  () => WorkforceForecastNight.WorkforceForecastNightPage(),
                ),
          ),
          GoRoute(
            path: Routes.workforceForecastFreshManufacturing.value,
            builder:
                (context, state) => _deferredBuilder(
                  WorkforceForecastFreshManufacturing.loadLibrary(),
                  () => WorkforceForecastFreshManufacturing.WorkforceForecastFreshManufacturingPage(),
                ),
          ),
          GoRoute(
            path: Routes.operationPlan.value,
            builder:
                (context, state) =>
                    _deferredBuilder(OperationPlan.loadLibrary(), () => OperationPlan.OperationPlanPage()),
          ),
          GoRoute(
            path: Routes.workAssignment.value,
            builder:
                (context, state) =>
                    _deferredBuilder(WorkAssignment.loadLibrary(), () => WorkAssignment.WorkAssignmentPage()),
          ),
          GoRoute(
            path: Routes.workModel.value,
            builder: (context, state) => _deferredBuilder(WorkModel.loadLibrary(), () => WorkModel.WorkModelPage()),
          ),
          GoRoute(
            path: Routes.progressPersonal.value,
            builder:
                (context, state) =>
                    _deferredBuilder(ProgressPersonal.loadLibrary(), () => ProgressPersonal.ProgressPersonalPage()),
          ),
          GoRoute(
            path: Routes.progressManager.value,
            builder:
                (context, state) =>
                    _deferredBuilder(ProgressManager.loadLibrary(), () => ProgressManager.ProgressManagerPage()),
          ),
          GoRoute(
            path: Routes.analyticsBudget.value,
            builder:
                (context, state) =>
                    _deferredBuilder(AnalyticsBudget.loadLibrary(), () => AnalyticsBudget.AnalyticsBudgetPage()),
          ),
          GoRoute(
            path: Routes.analyticsVariance.value,
            builder:
                (context, state) =>
                    _deferredBuilder(AnalyticsVariance.loadLibrary(), () => AnalyticsVariance.AnalyticsVariancePage()),
          ),
          GoRoute(
            path: Routes.analyticsProductivity.value,
            builder:
                (context, state) => _deferredBuilder(
                  AnalyticsProductivity.loadLibrary(),
                  () => AnalyticsProductivity.AnalyticsProductivityPage(),
                ),
          ),
          GoRoute(
            path: Routes.personalPlanRevision.value,
            builder:
                (context, state) => _deferredBuilder(
                  PersonalPlanRevision.loadLibrary(),
                  () => PersonalPlanRevision.PersonalPlanRevisionPage(),
                ),
          ),
          GoRoute(
            path: Routes.personalLeaveRequest.value,
            builder:
                (context, state) => _deferredBuilder(
                  PersonalLeaveRequest.loadLibrary(),
                  () => PersonalLeaveRequest.PersonalLeaveRequestPage(),
                ),
          ),
          GoRoute(
            path: Routes.personalScheduleChange.value,
            builder:
                (context, state) => _deferredBuilder(
                  PersonalScheduleChange.loadLibrary(),
                  () => PersonalScheduleChange.PersonalScheduleChangePage(),
                ),
          ),
          GoRoute(
            path: Routes.personalApplication.value,
            builder:
                (context, state) => _deferredBuilder(
                  PersonalApplication.loadLibrary(),
                  () => PersonalApplication.PersonalApplicationPage(),
                ),
          ),
        ],
      ),
    ],
  );

  ref.onDispose(notifier.dispose);

  return router;
}
