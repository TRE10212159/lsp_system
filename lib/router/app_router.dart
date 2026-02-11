import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../features/auth/providers/auth_provider.dart';
import '../features/auth/presentation/login_page.dart';
import '../features/home/presentation/home_page.dart';
import '../shared/widgets/app_scaffold.dart';
// 初回表示を軽くするため、以下は deferred で読み込む
import '../features/workforce_planning/presentation/workforce_forecast_page.dart'
    deferred as WorkforceForecast;
import '../features/workforce_planning/presentation/operation_plan_page.dart'
    deferred as OperationPlan;
import '../features/workforce_planning/presentation/work_assignment_page.dart'
    deferred as WorkAssignment;
import '../features/work_model/presentation/work_model_page.dart'
    deferred as WorkModel;
import '../features/progress/presentation/progress_personal_page.dart'
    deferred as ProgressPersonal;
import '../features/progress/presentation/progress_manager_page.dart'
    deferred as ProgressManager;
import '../features/progress/presentation/progress_completion_rate_page.dart'
    deferred as ProgressCompletionRate;
import '../features/analytics/presentation/analytics_budget_page.dart'
    deferred as AnalyticsBudget;
import '../features/analytics/presentation/analytics_variance_page.dart'
    deferred as AnalyticsVariance;
import '../features/analytics/presentation/analytics_productivity_page.dart'
    deferred as AnalyticsProductivity;
import '../features/personal/presentation/personal_plan_revision_page.dart'
    deferred as PersonalPlanRevision;
import '../features/personal/presentation/personal_leave_request_page.dart'
    deferred as PersonalLeaveRequest;
import '../features/personal/presentation/personal_schedule_change_page.dart'
    deferred as PersonalScheduleChange;
import '../features/personal/presentation/personal_application_page.dart'
    deferred as PersonalApplication;

part 'app_router.g.dart';

/// Deferred ロード中はローディング表示、完了後に子を表示する
Widget _deferredBuilder(
  Future<void> libraryFuture,
  Widget Function() buildChild,
) {
  return FutureBuilder<void>(
    future: libraryFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done &&
          !snapshot.hasError) {
        return buildChild();
      }
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    },
  );
}

/// 認証状態変更通知用のクラス
class AuthNotifier extends ChangeNotifier {
  final Ref _ref;
  ProviderSubscription? _subscription;

  AuthNotifier(this._ref) {
    _subscription = _ref.listen(
      authStateProvider,
      (_, __) => notifyListeners(),
    );
  }

  @override
  void dispose() {
    _subscription?.close();
    super.dispose();
  }
}

/// ルーター設定プロバイダー
@Riverpod(keepAlive: true)
GoRouter router(RouterRef ref) {
  final notifier = AuthNotifier(ref);

  final router = GoRouter(
    initialLocation: '/login',
    refreshListenable: notifier,
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final isLoginPage = state.matchedLocation == '/login';

      return authState.when(
        data: (isLoggedIn) {
          if (!isLoggedIn && !isLoginPage) {
            return '/login';
          }
          if (isLoggedIn && isLoginPage) {
            return '/home';
          }
          return null;
        },
        loading: () {
          if (isLoginPage) {
            return null;
          }
          return null;
        },
        error: (_, __) => '/login',
      );
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      ShellRoute(
        builder: (context, state, child) {
          return AppScaffold(child: child);
        },
        routes: [
          GoRoute(path: '/home', builder: (context, state) => const HomePage()),
          GoRoute(
            path: '/home/workforce-forecast',
            builder:
                (context, state) => _deferredBuilder(
                  WorkforceForecast.loadLibrary(),
                  () => WorkforceForecast.WorkforceForecastPage(),
                ),
          ),
          GoRoute(
            path: '/home/operation-plan',
            builder:
                (context, state) => _deferredBuilder(
                  OperationPlan.loadLibrary(),
                  () => OperationPlan.OperationPlanPage(),
                ),
          ),
          GoRoute(
            path: '/home/work-assignment',
            builder:
                (context, state) => _deferredBuilder(
                  WorkAssignment.loadLibrary(),
                  () => WorkAssignment.WorkAssignmentPage(),
                ),
          ),
          GoRoute(
            path: '/home/work-model',
            builder:
                (context, state) => _deferredBuilder(
                  WorkModel.loadLibrary(),
                  () => WorkModel.WorkModelPage(),
                ),
          ),
          GoRoute(
            path: '/home/progress/personal',
            builder:
                (context, state) => _deferredBuilder(
                  ProgressPersonal.loadLibrary(),
                  () => ProgressPersonal.ProgressPersonalPage(),
                ),
          ),
          GoRoute(
            path: '/home/progress/manager',
            builder:
                (context, state) => _deferredBuilder(
                  ProgressManager.loadLibrary(),
                  () => ProgressManager.ProgressManagerPage(),
                ),
          ),
          GoRoute(
            path: '/home/progress/completion-rate',
            builder:
                (context, state) => _deferredBuilder(
                  ProgressCompletionRate.loadLibrary(),
                  () => ProgressCompletionRate.ProgressCompletionRatePage(),
                ),
          ),
          GoRoute(
            path: '/home/analytics/budget-analysis',
            builder:
                (context, state) => _deferredBuilder(
                  AnalyticsBudget.loadLibrary(),
                  () => AnalyticsBudget.AnalyticsBudgetPage(),
                ),
          ),
          GoRoute(
            path: '/home/analytics/manhour-variance',
            builder:
                (context, state) => _deferredBuilder(
                  AnalyticsVariance.loadLibrary(),
                  () => AnalyticsVariance.AnalyticsVariancePage(),
                ),
          ),
          GoRoute(
            path: '/home/analytics/productivity',
            builder:
                (context, state) => _deferredBuilder(
                  AnalyticsProductivity.loadLibrary(),
                  () => AnalyticsProductivity.AnalyticsProductivityPage(),
                ),
          ),
          GoRoute(
            path: '/home/personal-services/plan-revision',
            builder:
                (context, state) => _deferredBuilder(
                  PersonalPlanRevision.loadLibrary(),
                  () => PersonalPlanRevision.PersonalPlanRevisionPage(),
                ),
          ),
          GoRoute(
            path: '/home/personal-services/leave-request',
            builder:
                (context, state) => _deferredBuilder(
                  PersonalLeaveRequest.loadLibrary(),
                  () => PersonalLeaveRequest.PersonalLeaveRequestPage(),
                ),
          ),
          GoRoute(
            path: '/home/personal-services/schedule-change',
            builder:
                (context, state) => _deferredBuilder(
                  PersonalScheduleChange.loadLibrary(),
                  () => PersonalScheduleChange.PersonalScheduleChangePage(),
                ),
          ),
          GoRoute(
            path: '/home/personal-services/application',
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
