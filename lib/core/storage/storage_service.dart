import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'storage_service.g.dart';

/// ストレージサービスプロバイダー
@riverpod
StorageService storageService(ref) {
  return StorageService();
}

/// ローカルストレージサービス
class StorageService {
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUsername = 'username';

  /// SharedPreferencesインスタンスを取得
  Future<SharedPreferences> get _prefs async {
    return await SharedPreferences.getInstance();
  }

  /// ログイン状態を保存
  Future<void> saveLoginState(bool isLoggedIn) async {
    final prefs = await _prefs;
    await prefs.setBool(_keyIsLoggedIn, isLoggedIn);
  }

  /// ログイン状態を取得
  Future<bool> isLoggedIn() async {
    final prefs = await _prefs;
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  /// ユーザー名を保存
  Future<void> saveUsername(String username) async {
    final prefs = await _prefs;
    await prefs.setString(_keyUsername, username);
  }

  /// ユーザー名を取得
  Future<String?> getUsername() async {
    final prefs = await _prefs;
    return prefs.getString(_keyUsername);
  }

  /// ログイン状態をクリア
  Future<void> clearLoginState() async {
    final prefs = await _prefs;
    await prefs.remove(_keyIsLoggedIn);
    await prefs.remove(_keyUsername);
  }
}
