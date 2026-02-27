import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_web/web.dart';

/// Flutter 起動後に HTML 側のローディングプレースホルダーを削除する。
/// Web では #flutter-loading を削除、それ以外では何もしない。
void removeLoadingPlaceholder() {
  if (kIsWeb) document.getElementById('flutter-loading')?.remove();
}
