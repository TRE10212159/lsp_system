import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page_scaffold.dart';

/// 有給・時間変更申請ページ
class PersonalScheduleChangePage extends StatelessWidget {
  const PersonalScheduleChangePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePageScaffold(
      title: '有給・時間変更申請',
      icon: Icons.schedule,
    );
  }
}

