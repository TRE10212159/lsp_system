import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page_scaffold.dart';

/// 希望休みや希望時間申請ページ
class PersonalLeaveRequestPage extends StatelessWidget {
  const PersonalLeaveRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePageScaffold(
      title: '希望休みや希望時間申請',
      icon: Icons.event_available,
    );
  }
}

