import 'loading_placeholder_stub.dart'
    if (dart.library.html) 'loading_placeholder_web.dart'
    as impl;

/// Flutter 起動後に HTML 側のローディングプレースホルダーを削除する。
/// Web では #flutter-loading を削除、それ以外では何もしない。
void removeLoadingPlaceholder() {
  impl.removeLoadingPlaceholder();
}
