import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page_scaffold.dart';

/// 夜間人時予測ページ
class WorkforceForecastNightPage extends StatelessWidget {
  const WorkforceForecastNightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePageScaffold(title: '夜間人時予測', icon: Icons.analytics);
  }
}
