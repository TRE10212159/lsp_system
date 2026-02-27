import 'package:lsp_system/core/constants/base_states.dart';
import 'package:lsp_system/core/constants/dictionary.dart';

/// ルートパス定数（命名定数 + リスト取得）
class Routes {
  Routes._();

  /// ログイン
  static final BaseOption login = BaseOption(value: '/login', label: Dictionary.login.t());

  /// ホーム
  static final BaseOption home = BaseOption(value: '/home', label: Dictionary.home.t());

  /// 作業モデル管理
  static final BaseOption workModel = BaseOption(value: '/home/work-model', label: Dictionary.workModel.t());

  /// 直近物量変動人時予測
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
  static final BaseOption attendancePlan = BaseOption(
    value: '/home/attendance-plan',
    label: Dictionary.attendancePlan.t(),
  );

  /// 作業割当
  static final BaseOption workAssignment = BaseOption(
    value: '/home/work-assignment',
    label: Dictionary.workAssignment.t(),
  );

  /// 作業実績進捗管理
  static final BaseOption progress = BaseOption(value: 'progress', label: Dictionary.progress.t());

  /// 個人作業実績管理
  static final BaseOption progressPersonal = BaseOption(
    value: '/home/progress/personal',
    label: Dictionary.progressPersonal.t(),
  );

  /// MGR作業進捗管理
  static final BaseOption progressManager = BaseOption(
    value: '/home/progress/manager',
    label: Dictionary.progressManager.t(),
  );

  /// 分析レポート
  static final BaseOption analysis = BaseOption(value: 'analysis', label: Dictionary.analysis.t());

  /// 分析レポート - 予算計画実績契約分析
  static final BaseOption analysisBudget = BaseOption(
    value: '/home/analysis/budget',
    label: Dictionary.analysisBudget.t(),
  );

  /// 分析レポート - 必要人時と契約差異分析
  static final BaseOption analysisVariance = BaseOption(
    value: '/home/analysis/variance',
    label: Dictionary.analysisVariance.t(),
  );

  /// 分析レポート - 人時生産性
  static final BaseOption analysisProductivity = BaseOption(
    value: '/home/analysis/productivity',
    label: Dictionary.analysisProductivity.t(),
  );

  /// 個人サービス
  static final BaseOption personalServices = BaseOption(
    value: 'personal-services',
    label: Dictionary.personalServices.t(),
  );

  /// 個人サービス - 個人計画修正
  static final BaseOption personalPlanRevision = BaseOption(
    value: '/home/personal-services/plan-revision',
    label: Dictionary.personalPlanRevision.t(),
  );

  /// 個人サービス - 希望休・希望時間申請
  static final BaseOption personalMakeUpLeave = BaseOption(
    value: '/home/personal-services/makeup-leave',
    label: Dictionary.personalMakeUpLeave.t(),
  );

  /// 個人サービス - 有給・時間変更申請
  static final BaseOption personalAnnualLeave = BaseOption(
    value: '/home/personal-services/annual-leave',
    label: Dictionary.personalAnnualLeave.t(),
  );

  /// 個人サービス - 応募
  static final BaseOption personalApplyJob = BaseOption(
    value: '/home/personal-services/apply-job',
    label: Dictionary.personalApplyJob.t(),
  );

  /// 全ルートをリストで取得（サイドバー・メニュー等で利用）
  static List<BaseOption> get all => [
    login,
    home,
    workforceForecastRegister,
    workforceForecastNight,
    workforceForecastFreshManufacturing,
    attendancePlan,
    workAssignment,
    workModel,
    progressPersonal,
    progressManager,
    analysis,
    analysisBudget,
    analysisVariance,
    analysisProductivity,
    personalPlanRevision,
    personalMakeUpLeave,
    personalAnnualLeave,
    personalApplyJob,
  ];

  static String getRouteName(String path) {
    return all.firstWhere((option) => option.value == path).label;
  }
}
