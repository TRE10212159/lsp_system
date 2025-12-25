import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page_scaffold.dart';

/// MGR作業進捗管理ページ
class ProgressManagerPage extends StatelessWidget {
  const ProgressManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePageScaffold(
      title: 'MGR作業進捗管理',
      icon: Icons.supervisor_account,
    );
  }
}

