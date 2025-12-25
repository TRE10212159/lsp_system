import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page_scaffold.dart';

/// 予算計画実績契約分析ページ
class AnalyticsBudgetPage extends StatelessWidget {
  const AnalyticsBudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePageScaffold(
      title: '予算計画実績契約分析',
      icon: Icons.account_balance,
    );
  }
}
