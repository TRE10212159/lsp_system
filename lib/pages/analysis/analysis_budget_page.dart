import 'package:flutter/material.dart';
import 'package:lsp_system/core/constants/dictionary.dart';
import 'package:lsp_system/shared/widgets/icons.dart';

import 'package:lsp_system/pages/aaaaaa_test_page_build.dart';

/// 予算計画実績契約分析ページ
class AnalysisBudgetPage extends StatelessWidget {
  const AnalysisBudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return testPageBuild(context, ChartBarIcon(), Dictionary.analysisBudget.t());
  }
}
