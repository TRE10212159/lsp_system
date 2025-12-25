import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page_scaffold.dart';

/// 個人作業実績管理ページ
class ProgressPersonalPage extends StatelessWidget {
  const ProgressPersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePageScaffold(
      title: '個人作業実績管理',
      icon: Icons.person,
    );
  }
}

