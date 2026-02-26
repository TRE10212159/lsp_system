/// 文案键：类型安全，便于补全与重构。
enum Dictionary {
  appName,
  login,
  home,
  workforceForecast,
  workforceForecastRegister,
  workforceForecastNight,
  workforceForecastFreshManufacturing,
  operationPlan,
  workAssignment,
  workModel,
  progress,
  progressPersonal,
  progressManager,
  analytics,
  analyticsBudget,
  analyticsVariance,
  analyticsProductivity,
  personalServices,
  personalPlanRevision,
  personalLeaveRequest,
  personalScheduleChange,
  personalApplication,
}

/// 当前使用的文案表（可按需扩展多语言）。
const _strings = <Dictionary, _DictionaryText>{
  // common
  Dictionary.appName: _DictionaryText('LSPシステム'),
  Dictionary.login: _DictionaryText('ログイン'),
  // menu
  Dictionary.home: _DictionaryText('ホーム'),
  Dictionary.workforceForecast: _DictionaryText('直近物量変動人時予測'),
  Dictionary.workforceForecastRegister: _DictionaryText('レジ人時予測'),
  Dictionary.workforceForecastNight: _DictionaryText('夜間人時予測'),
  Dictionary.workforceForecastFreshManufacturing: _DictionaryText('生鮮製造人時予測'),
  Dictionary.operationPlan: _DictionaryText('稼働計画'),
  Dictionary.workAssignment: _DictionaryText('作業割当'),
  Dictionary.workModel: _DictionaryText('作業モデル管理'),
  Dictionary.progress: _DictionaryText('作業実績進捗管理'),
  Dictionary.progressPersonal: _DictionaryText('個人作業実績管理'),
  Dictionary.progressManager: _DictionaryText('MGR作業進捗管理'),
  Dictionary.analytics: _DictionaryText('分析レポート'),
  Dictionary.analyticsBudget: _DictionaryText('予算計画実績合同分析'),
  Dictionary.analyticsVariance: _DictionaryText('必要人時と契約差異分析'),
  Dictionary.analyticsProductivity: _DictionaryText('人時生産性'),
  Dictionary.personalServices: _DictionaryText('個人サービス'),
  Dictionary.personalPlanRevision: _DictionaryText('個人計画修正'),
  Dictionary.personalLeaveRequest: _DictionaryText('希望休・希望時間申請'),
  Dictionary.personalScheduleChange: _DictionaryText('有給・時間変更申請'),
  Dictionary.personalApplication: _DictionaryText('応募'),
};

/// 可带占位符的文案；占位符用 [fill] 替换。
extension type const _DictionaryText(String value) {
  String fill(Map<String, Object> params) {
    String text = value;
    for (final e in params.entries) {
      text = text.replaceAll(e.key, e.value.toString());
    }
    return text;
  }

  String get text => value;
}

/// 词典：统一取文案。轻量、无外部依赖。
class _L10n {
  _L10n._();

  /// 取文案；[params] 非空时替换占位符，缺 key 时回退为 [key.name]。
  static String getText(Dictionary key, {Map<String, Object>? params}) {
    final s = _strings[key];
    if (s == null) return key.name;
    if (params != null && params.isNotEmpty) return s.fill(params);
    return s.text;
  }
}

/// 扩展：可直接写 [Dictionary.appName.t] 或 [Dictionary.xxx.t(params: {...})]。
extension DictionaryExtension on Dictionary {
  String t([Map<String, Object>? params]) => _L10n.getText(this, params: params);
}
