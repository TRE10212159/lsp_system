import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page_scaffold.dart';

/// 人時生産性ページ
class AnalyticsProductivityPage extends StatelessWidget {
  const AnalyticsProductivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePageScaffold(title: '人時生産性', icon: Icons.trending_up);
  }
}
