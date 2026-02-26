import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page_scaffold.dart';

/// レジ人時予測ページ
class WorkforceForecastRegisterPage extends StatelessWidget {
  const WorkforceForecastRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePageScaffold(title: 'レジ人時予測', icon: Icons.analytics);
  }
}
