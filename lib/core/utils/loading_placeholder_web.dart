import 'dart:html' as html;

/// Web: HTML のローディング用プレースホルダーを削除する
void removeLoadingPlaceholder() {
  html.document.getElementById('flutter-loading')?.remove();
}
