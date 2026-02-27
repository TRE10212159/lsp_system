import 'package:flutter/material.dart';
import 'package:lsp_system/core/constants/dictionary.dart';
import 'package:lsp_system/shared/widgets/icons.dart';

import 'package:lsp_system/pages/aaaaaa_test_page_build.dart';

/// 生鮮製造人時予測ページ
class ForecastFreshPage extends StatelessWidget {
  const ForecastFreshPage({super.key});

  @override
  Widget build(BuildContext context) {
    return testPageBuild(context, UtensilsIcon(), Dictionary.workforceForecastFreshManufacturing.t());
  }
}
