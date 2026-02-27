import 'package:flutter/material.dart';
import 'package:lsp_system/core/constants/dictionary.dart';
import 'package:lsp_system/shared/widgets/icons.dart';

import 'package:lsp_system/pages/aaaaaa_test_page_build.dart';

/// 応募ページ
class ApplyJobPage extends StatelessWidget {
  const ApplyJobPage({super.key});

  @override
  Widget build(BuildContext context) {
    return testPageBuild(context, BriefcaseIcon(), Dictionary.personalApplyJob.t());
  }
}
