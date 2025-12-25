/// ユーザーモデル
class UserModel {
  /// ユーザー名
  final String username;

  /// メールアドレス
  final String? email;

  const UserModel({required this.username, this.email});

  /// JSON形式からモデルを作成
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] as String,
      email: json['email'] as String?,
    );
  }

  /// モデルをJSON形式に変換
  Map<String, dynamic> toJson() {
    return {'username': username, 'email': email};
  }
}
