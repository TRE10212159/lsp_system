import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page_scaffold.dart';

/// 生鮮製造人時予測ページ
class WorkforceForecastFreshManufacturingPage extends StatelessWidget {
  const WorkforceForecastFreshManufacturingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePageScaffold(title: '生鮮製造人時予測', icon: Icons.analytics);
  }
}
