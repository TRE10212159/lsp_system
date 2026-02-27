import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../storage/storage_service.dart';

part 'auth_provider.g.dart';

/// 認証状態プロバイダー（非同期版）
@riverpod
class AuthState extends _$AuthState {
  @override
  Future<bool> build() async {
    final storage = ref.read(storageServiceProvider);
    final isLoggedIn = await storage.isLoggedIn();
    return isLoggedIn;
  }

  /// ログイン処理
  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (username == 'admin' && password == 'admin') {
      final storage = ref.read(storageServiceProvider);
      await storage.saveLoginState(true);
      await storage.saveUsername(username);
      state = const AsyncValue.data(true);
      return true;
    }
    return false;
  }

  /// ログアウト処理
  Future<void> logout() async {
    final storage = ref.read(storageServiceProvider);
    await storage.clearLoginState();
    state = const AsyncValue.data(false);
  }
}
