import 'package:flutter/material.dart';
import 'package:lsp_system/shared/widgets/icons.dart';

import 'package:lsp_system/pages/aaaaaa_test_page_build.dart';

/// ホームページ
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return testPageBuild(context, HouseIcon(), 'LSPシステムへようこそ', tip: '左のメニューから機能を選択してください');
  }
}
