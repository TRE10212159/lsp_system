import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page_scaffold.dart';

/// 作業モデル管理ページ
class WorkModelPage extends StatelessWidget {
  const WorkModelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePageScaffold(
      title: '作業モデル管理',
      icon: Icons.settings,
    );
  }
}

