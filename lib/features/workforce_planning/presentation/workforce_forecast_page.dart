import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page_scaffold.dart';

/// 必要人時予測ページ
class WorkforceForecastPage extends StatelessWidget {
  const WorkforceForecastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePageScaffold(
      title: '必要人時予測',
      icon: Icons.analytics,
    );
  }
}

