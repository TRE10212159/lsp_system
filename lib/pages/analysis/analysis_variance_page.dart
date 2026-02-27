import 'package:flutter/material.dart';
import 'package:lsp_system/core/constants/dictionary.dart';
import 'package:lsp_system/shared/widgets/icons.dart';

import 'package:lsp_system/pages/aaaaaa_test_page_build.dart';

/// 必要人時と契約差異分析ページ
class AnalysisVariancePage extends StatelessWidget {
  const AnalysisVariancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return testPageBuild(context, ChartLineIcon(), Dictionary.analysisVariance.t());
  }
}
