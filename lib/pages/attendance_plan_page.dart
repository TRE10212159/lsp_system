import 'package:flutter/material.dart';
import 'package:lsp_system/core/constants/dictionary.dart';
import 'package:lsp_system/shared/widgets/icons.dart';

import 'package:lsp_system/pages/aaaaaa_test_page_build.dart';

/// 勤怠計画ページ
class AttendancePlanPage extends StatelessWidget {
  const AttendancePlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return testPageBuild(context, CalendarDaysIcon(), Dictionary.attendancePlan.t());
  }
}
