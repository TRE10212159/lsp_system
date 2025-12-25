import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page_scaffold.dart';

/// 作業完了率ページ
class ProgressCompletionRatePage extends StatelessWidget {
  const ProgressCompletionRatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePageScaffold(
      title: '作業完了率',
      icon: Icons.check_circle,
    );
  }
}

