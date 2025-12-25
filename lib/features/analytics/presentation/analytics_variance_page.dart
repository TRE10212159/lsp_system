import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page_scaffold.dart';

/// 必要人時と契約差異分析ページ
class AnalyticsVariancePage extends StatelessWidget {
  const AnalyticsVariancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePageScaffold(
      title: '必要人時と契約差異分析',
      icon: Icons.compare_arrows,
    );
  }
}
