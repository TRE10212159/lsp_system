import 'package:flutter/material.dart';
import 'package:lsp_system/core/constants/dictionary.dart';
import 'package:lsp_system/shared/widgets/icons.dart';

import 'package:lsp_system/pages/aaaaaa_test_page_build.dart';

/// 希望休・希望時間申請ページ
class MakeupLeavePage extends StatelessWidget {
  const MakeupLeavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return testPageBuild(context, CalendarCheckIcon(), Dictionary.personalMakeUpLeave.t());
  }
}
