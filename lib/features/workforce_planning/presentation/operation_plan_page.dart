import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page_scaffold.dart';

/// 稼働計画ページ
class OperationPlanPage extends StatelessWidget {
  const OperationPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePageScaffold(
      title: '稼働計画',
      icon: Icons.calendar_today,
    );
  }
}

