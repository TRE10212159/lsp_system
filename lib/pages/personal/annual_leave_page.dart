import 'package:flutter/material.dart';
import 'package:lsp_system/core/constants/dictionary.dart';
import 'package:lsp_system/shared/widgets/icons.dart';

import 'package:lsp_system/pages/aaaaaa_test_page_build.dart';

/// 有給・時間変更申請ページ
class AnnualLeavePage extends StatelessWidget {
  const AnnualLeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return testPageBuild(context, ClockIcon(), Dictionary.personalAnnualLeave.t());
  }
}
