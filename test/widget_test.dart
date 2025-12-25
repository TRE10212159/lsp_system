import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lsp_system/app.dart';

/// アプリケーションの基本テスト
void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    /// アプリを起動してフレームをトリガー
    await tester.pumpWidget(
      const ProviderScope(
        child: App(),
      ),
    );

    /// 初期画面がログインページであることを確認
    expect(find.text('LSP System'), findsWidgets);
  });
}
