import 'package:flutter/material.dart';
import 'package:lsp_system/core/constants/dictionary.dart';
import 'package:lsp_system/shared/widgets/icons.dart';

import 'package:lsp_system/pages/aaaaaa_test_page_build.dart';

/// 作業モデル管理ページ
class WorkModelPage extends StatelessWidget {
  const WorkModelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return testPageBuild(context, CubesIcon(), Dictionary.workModel.t());
  }
}
