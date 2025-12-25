import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page_scaffold.dart';

/// 個人計画修正ページ
class PersonalPlanRevisionPage extends StatelessWidget {
  const PersonalPlanRevisionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePageScaffold(
      title: '個人計画修正',
      icon: Icons.edit_calendar,
    );
  }
}

