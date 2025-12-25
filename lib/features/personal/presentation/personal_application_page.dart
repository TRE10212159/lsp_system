import 'package:flutter/material.dart';
import '../../../shared/widgets/feature_page_scaffold.dart';

/// 応募ページ
class PersonalApplicationPage extends StatelessWidget {
  const PersonalApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePageScaffold(
      title: '応募',
      icon: Icons.send,
    );
  }
}

