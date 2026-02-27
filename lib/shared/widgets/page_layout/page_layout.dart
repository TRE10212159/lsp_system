import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lsp_system/shared/widgets/page_layout/page_header.dart';
import 'page_sidebar.dart';

/// アプリケーションの共通スキャフォールド
class PageLayout extends ConsumerStatefulWidget {
  /// 表示する子ウィジェット
  final Widget child;

  const PageLayout({super.key, required this.child});

  @override
  ConsumerState<PageLayout> createState() => _PageLayout();
}

class _PageLayout extends ConsumerState<PageLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            PageSidebar(),
            Expanded(child: Column(children: [PageHeader(), Expanded(child: widget.child)])),
          ],
        ),
      ),
    );
  }
}
