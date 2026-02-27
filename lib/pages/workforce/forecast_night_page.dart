import 'package:flutter/material.dart';
import 'package:lsp_system/core/constants/dictionary.dart';
import 'package:lsp_system/shared/widgets/icons.dart';

import 'package:lsp_system/pages/aaaaaa_test_page_build.dart';

/// 夜間人時予測ページ
class ForecastNightPage extends StatelessWidget {
  const ForecastNightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return testPageBuild(context, MoonIcon(), Dictionary.workforceForecastNight.t());
  }
}
