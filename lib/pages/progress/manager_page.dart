import 'package:flutter/material.dart';
import 'package:lsp_system/core/constants/dictionary.dart';
import 'package:lsp_system/shared/widgets/icons.dart';

import 'package:lsp_system/pages/aaaaaa_test_page_build.dart';

/// MGR作業進捗管理ページ
class ProgressManagerPage extends StatelessWidget {
  const ProgressManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return testPageBuild(context, UsersIcon(), Dictionary.progressManager.t());
  }
}
