import 'package:flutter/material.dart';
import 'package:lsp_system/core/constants/dictionary.dart';
import 'package:lsp_system/shared/widgets/icons.dart';

import 'package:lsp_system/pages/aaaaaa_test_page_build.dart';

/// 個人作業実績管理ページ
class ProgressPersonalPage extends StatelessWidget {
  const ProgressPersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return testPageBuild(context, UserIcon(), Dictionary.progressPersonal.t());
  }
}
