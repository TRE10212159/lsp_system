import 'package:lsp_system/constants/base_states.dart';
import 'package:lsp_system/constants/dictionary.dart';

/// ルートパス定数（命名定数 + リスト取得）
class Routes {
  Routes._();

  /// ログインページ
  static final BaseOption login = BaseOption(value: '/login', label: Dictionary.login.t());

  /// ホームページ
  static final BaseOption home = BaseOption(value: '/home', label: Dictionary.home.t());

  static final BaseOption workforceForecast = BaseOption(
    value: 'workforce-forecast',
    label: Dictionary.workforceForecast.t(),
  );

  /// 直近物量変動人時予測 - レジ人時予測
  static final BaseOption workforceForecastRegister = BaseOption(
    value: '/home/workforce-forecast/register',
    label: Dictionary.workforceForecastRegister.t(),
  );

  /// 直近物量変動人時予測 - 夜間人時予測
  static final BaseOption workforceForecastNight = BaseOption(
    value: '/home/workforce-forecast/night',
    label: Dictionary.workforceForecastNight.t(),
  );

  /// 直近物量変動人時予測 - 生鮮製造人時予測
  static final BaseOption workforceForecastFreshManufacturing = BaseOption(
    value: '/home/workforce-forecast/fresh-manufacturing',
    label: Dictionary.workforceForecastFreshManufacturing.t(),
  );

  /// 稼働計画
  static final BaseOption operationPlan = BaseOption(
    value: '/home/operation-plan',
    label: Dictionary.operationPlan.t(),
  );

  /// 作業割当
  static final BaseOption workAssignment = BaseOption(
    value: '/home/work-assignment',
    label: Dictionary.workAssignment.t(),
  );

  /// 作業モデル管理
  static final BaseOption workModel = BaseOption(value: '/home/work-model', label: Dictionary.workModel.t());

  /// 作業実績進捗管理
  static final BaseOption progress = BaseOption(value: 'progress', label: Dictionary.progress.t());

  /// 個人作業実績管理
  static final BaseOption progressPersonal = BaseOption(
    value: '/home/progress/personal',
    label: Dictionary.progressPersonal.t(),
  );

  /// MGR 作業進捗管理
  static final BaseOption progressManager = BaseOption(
    value: '/home/progress/manager',
    label: Dictionary.progressManager.t(),
  );

  /// 分析レポート
  static final BaseOption analytics = BaseOption(value: 'analytics', label: Dictionary.analytics.t());

  /// 予算計画実績契約分析
  static final BaseOption analyticsBudget = BaseOption(
    value: '/home/analytics/budget-analysis',
    label: Dictionary.analyticsBudget.t(),
  );

  /// 必要人時と契約差異分析
  static final BaseOption analyticsVariance = BaseOption(
    value: '/home/analytics/manhour-variance',
    label: Dictionary.analyticsVariance.t(),
  );

  /// 人時生産性
  static final BaseOption analyticsProductivity = BaseOption(
    value: '/home/analytics/productivity',
    label: Dictionary.analyticsProductivity.t(),
  );

  /// デジタル個人サービス
  static final BaseOption personalServices = BaseOption(
    value: 'personal-services',
    label: Dictionary.personalServices.t(),
  );

  /// 個人計画修正
  static final BaseOption personalPlanRevision = BaseOption(
    value: '/home/personal-services/plan-revision',
    label: Dictionary.personalPlanRevision.t(),
  );

  /// 希望休みや希望時間申請
  static final BaseOption personalLeaveRequest = BaseOption(
    value: '/home/personal-services/leave-request',
    label: Dictionary.personalLeaveRequest.t(),
  );

  /// 有給・時間変更申請
  static final BaseOption personalScheduleChange = BaseOption(
    value: '/home/personal-services/schedule-change',
    label: Dictionary.personalScheduleChange.t(),
  );

  /// 応募
  static final BaseOption personalApplication = BaseOption(
    value: '/home/personal-services/application',
    label: Dictionary.personalApplication.t(),
  );

  /// 全ルートをリストで取得（サイドバー・メニュー等で利用）
  static List<BaseOption> get all => [
    login,
    home,
    workforceForecastRegister,
    workforceForecastNight,
    workforceForecastFreshManufacturing,
    operationPlan,
    workAssignment,
    workModel,
    progressPersonal,
    progressManager,
    analytics,
    analyticsBudget,
    analyticsVariance,
    analyticsProductivity,
    personalPlanRevision,
    personalLeaveRequest,
    personalScheduleChange,
    personalApplication,
  ];

  static String getRouteName(String path) {
    return all.firstWhere((option) => option.value == path).label;
  }
}
