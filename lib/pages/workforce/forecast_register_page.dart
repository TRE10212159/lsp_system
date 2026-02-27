import 'package:flutter/material.dart';
import 'package:lsp_system/core/constants/dictionary.dart';
import 'package:lsp_system/shared/widgets/icons.dart';

import 'package:lsp_system/pages/aaaaaa_test_page_build.dart';

/// レジ人時予測ページ
class ForecastRegisterPage extends StatelessWidget {
  const ForecastRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return testPageBuild(context, CalculatorIcon(), Dictionary.workforceForecastRegister.t());
  }
}
