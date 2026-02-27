import 'package:flutter/material.dart';
import 'package:lsp_system/core/constants/dictionary.dart';
import 'package:lsp_system/shared/widgets/icons.dart';

import 'package:lsp_system/pages/aaaaaa_test_page_build.dart';

/// 個人計画修正ページ
class PlanRevisionPage extends StatelessWidget {
  const PlanRevisionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return testPageBuild(context, PenToSquareIcon(), Dictionary.personalPlanRevision.t());
  }
}
