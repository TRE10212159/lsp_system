import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page_scaffold.dart';

/// 作業割当ページ
class WorkAssignmentPage extends StatelessWidget {
  const WorkAssignmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePageScaffold(title: '作業割当', icon: Icons.assignment);
  }
}
