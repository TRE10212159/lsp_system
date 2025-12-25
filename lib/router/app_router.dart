import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../features/auth/providers/auth_provider.dart';
import '../features/auth/presentation/login_page.dart';
import '../features/home/presentation/home_page.dart';
import '../features/workforce_planning/presentation/workforce_forecast_page.dart';
import '../features/workforce_planning/presentation/operation_plan_page.dart';
import '../features/workforce_planning/presentation/work_assignment_page.dart';
import '../features/work_model/presentation/work_model_page.dart';
import '../features/progress/presentation/progress_personal_page.dart';
import '../features/progress/presentation/progress_manager_page.dart';
import '../features/progress/presentation/progress_completion_rate_page.dart';
import '../features/analytics/presentation/analytics_budget_page.dart';
import '../features/analytics/presentation/analytics_variance_page.dart';
import '../features/analytics/presentation/analytics_productivity_page.dart';
import '../features/personal/presentation/personal_plan_revision_page.dart';
import '../features/personal/presentation/personal_leave_request_page.dart';
import '../features/personal/presentation/personal_schedule_change_page.dart';
import '../features/personal/presentation/personal_application_page.dart';
import '../shared/widgets/app_scaffold.dart';

part 'app_router.g.dart';

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
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return AppScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/home/workforce-forecast',
            builder: (context, state) => const WorkforceForecastPage(),
          ),
          GoRoute(
            path: '/home/operation-plan',
            builder: (context, state) => const OperationPlanPage(),
          ),
          GoRoute(
            path: '/home/work-assignment',
            builder: (context, state) => const WorkAssignmentPage(),
          ),
          GoRoute(
            path: '/home/work-model',
            builder: (context, state) => const WorkModelPage(),
          ),
          GoRoute(
            path: '/home/progress/personal',
            builder: (context, state) => const ProgressPersonalPage(),
          ),
          GoRoute(
            path: '/home/progress/manager',
            builder: (context, state) => const ProgressManagerPage(),
          ),
          GoRoute(
            path: '/home/progress/completion-rate',
            builder: (context, state) => const ProgressCompletionRatePage(),
          ),
          GoRoute(
            path: '/home/analytics/budget-analysis',
            builder: (context, state) => const AnalyticsBudgetPage(),
          ),
          GoRoute(
            path: '/home/analytics/manhour-variance',
            builder: (context, state) => const AnalyticsVariancePage(),
          ),
          GoRoute(
            path: '/home/analytics/productivity',
            builder: (context, state) => const AnalyticsProductivityPage(),
          ),
          GoRoute(
            path: '/home/personal-services/plan-revision',
            builder: (context, state) => const PersonalPlanRevisionPage(),
          ),
          GoRoute(
            path: '/home/personal-services/leave-request',
            builder: (context, state) => const PersonalLeaveRequestPage(),
          ),
          GoRoute(
            path: '/home/personal-services/schedule-change',
            builder: (context, state) => const PersonalScheduleChangePage(),
          ),
          GoRoute(
            path: '/home/personal-services/application',
            builder: (context, state) => const PersonalApplicationPage(),
          ),
        ],
      ),
    ],
  );

  ref.onDispose(notifier.dispose);

  return router;
}

