# Flutter アップグレード問題の解決方法

## 問題の症状

`flutter upgrade` コマンドを実行した際に、以下のエラーが発生する：

```
Unable to upgrade Flutter: The Flutter SDK is tracking a non-standard remote "https://mirrors.tuna.tsinghua.edu.cn/git/flutter-sdk.git".
Set the environment variable "FLUTTER_GIT_URL" to "https://mirrors.tuna.tsinghua.edu.cn/git/flutter-sdk.git". If this is intentional, it is
recommended to use "git" directly to manage the SDK.
Reinstalling Flutter may fix this issue. Visit https://flutter.dev/setup for instructions.
```

## 原因分析

### 主な原因

Flutter SDK が非標準のリモートリポジトリ（例：中国のミラーサイト）を追跡している場合、`flutter upgrade` コマンドが標準のアップグレードプロセスを実行できません。

### よくある状況

- Flutter SDK をミラーサイトからクローンした場合
- 環境変数が設定されていない場合
- Flutter SDK の Git リモート設定が変更されている場合

## 解決方法

### 方法 1: 環境変数を設定してアップグレード（推奨）

#### PowerShell で一時的に設定

```powershell
# 中国のミラーサイトを使用している場合
$env:FLUTTER_GIT_URL="https://mirrors.tuna.tsinghua.edu.cn/git/flutter-sdk.git"
$env:PUB_HOSTED_URL="https://pub.flutter-io.cn"
$env:FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"

# アップグレードを実行
flutter upgrade
```

#### コマンドプロンプト（CMD）で一時的に設定

```cmd
set FLUTTER_GIT_URL=https://mirrors.tuna.tsinghua.edu.cn/git/flutter-sdk.git
set PUB_HOSTED_URL=https://pub.flutter-io.cn
set FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

flutter upgrade
```

### 方法 2: システム環境変数を永続的に設定（Windows）

#### ステップ 1: システムのプロパティを開く

1. `Win + R` を押す
2. `sysdm.cpl` と入力して Enter
3. 「詳細設定」タブを選択
4. 「環境変数」ボタンをクリック

#### ステップ 2: 環境変数を追加

**ユーザー環境変数**または**システム環境変数**に以下を追加：

| 変数名 | 値 |
| ------ | --- |
| `FLUTTER_GIT_URL` | `https://mirrors.tuna.tsinghua.edu.cn/git/flutter-sdk.git` |
| `PUB_HOSTED_URL` | `https://pub.flutter-io.cn` |
| `FLUTTER_STORAGE_BASE_URL` | `https://storage.flutter-io.cn` |

#### ステップ 3: PowerShell を再起動

環境変数を設定した後、PowerShell またはコマンドプロンプトを再起動してから：

```powershell
flutter upgrade
```

### 方法 3: Git で直接管理する

Flutter SDK のディレクトリに移動して、Git コマンドで直接アップグレード：

#### ステップ 1: Flutter SDK のパスを確認

```powershell
flutter --version
# または
where.exe flutter
```

通常は `C:\src\flutter` または `C:\flutter` など。

#### ステップ 2: Flutter SDK ディレクトリに移動

```powershell
cd C:\src\flutter
# または実際のパスに置き換える
```

#### ステップ 3: Git でアップグレード

```powershell
# 現在のブランチを確認
git branch

# 最新の変更を取得
git fetch

# アップグレード（通常は stable ブランチ）
git checkout stable
git pull

# または特定のバージョンに切り替え
git checkout <version-tag>
```

#### ステップ 4: Flutter を再セットアップ

```powershell
cd <プロジェクトのパス>
flutter doctor
flutter pub get
```

### 方法 4: Flutter SDK を再インストール

既存の Flutter SDK に問題がある場合、再インストールを検討：

#### ステップ 1: 現在の Flutter SDK をバックアップ（オプション）

```powershell
# Flutter SDK のパスを確認
where.exe flutter

# バックアップを作成（必要に応じて）
```

#### ステップ 2: 新しい Flutter SDK をダウンロード

1. [Flutter 公式サイト](https://flutter.dev/docs/get-started/install/windows)から最新版をダウンロード
2. またはミラーサイトからダウンロード

#### ステップ 3: 環境変数を更新

`PATH` 環境変数に新しい Flutter SDK のパスを追加。

#### ステップ 4: 確認

```powershell
flutter --version
flutter doctor
```

## 中国のミラーサイトを使用する場合の完全な設定

### PowerShell プロファイルに追加（推奨）

PowerShell プロファイルを編集：

```powershell
# プロファイルを開く
notepad $PROFILE
```

以下を追加：

```powershell
# Flutter 中国ミラーサイト設定
$env:FLUTTER_GIT_URL="https://mirrors.tuna.tsinghua.edu.cn/git/flutter-sdk.git"
$env:PUB_HOSTED_URL="https://pub.flutter-io.cn"
$env:FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
```

保存後、PowerShell を再起動すると自動的に設定されます。

### バッチファイルで設定

`setup-flutter-env.bat` を作成：

```batch
@echo off
set FLUTTER_GIT_URL=https://mirrors.tuna.tsinghua.edu.cn/git/flutter-sdk.git
set PUB_HOSTED_URL=https://pub.flutter-io.cn
set FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
echo Flutter 環境変数が設定されました。
```

使用する前に実行：

```cmd
setup-flutter-env.bat
flutter upgrade
```

## トラブルシューティング

### 問題: 環境変数を設定してもエラーが続く

**解決策:**

1. PowerShell またはコマンドプロンプトを完全に再起動
2. 環境変数が正しく設定されているか確認：

```powershell
echo $env:FLUTTER_GIT_URL
```

3. Flutter SDK の Git リモートを確認：

```powershell
cd <Flutter SDK のパス>
git remote -v
```

### 問題: Git リモートが正しく設定されていない

**解決策:**

Flutter SDK ディレクトリで Git リモートを確認・修正：

```powershell
cd <Flutter SDK のパス>

# 現在のリモートを確認
git remote -v

# リモートを修正（必要に応じて）
git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/flutter-sdk.git

# または公式リポジトリに戻す
git remote set-url origin https://github.com/flutter/flutter.git
```

### 問題: アップグレード後にプロジェクトでエラーが発生

**解決策:**

1. Flutter をクリーン：

```powershell
flutter clean
```

2. 依存関係を再取得：

```powershell
flutter pub get
```

3. Flutter Doctor で問題を確認：

```powershell
flutter doctor -v
```

## 推奨されるワークフロー

### 日常のアップグレード手順

1. **環境変数を設定**（必要に応じて）

```powershell
$env:FLUTTER_GIT_URL="https://mirrors.tuna.tsinghua.edu.cn/git/flutter-sdk.git"
```

2. **アップグレードを実行**

```powershell
flutter upgrade
```

3. **プロジェクトを更新**

```powershell
cd <プロジェクトのパス>
flutter pub get
flutter doctor
```

### 定期的なメンテナンス

- 月に1回程度 `flutter upgrade` を実行
- アップグレード後は `flutter doctor` で問題を確認
- プロジェクトの依存関係を更新：`flutter pub upgrade`

## まとめ

### 最も簡単な解決方法

**PowerShell で一時的に環境変数を設定：**

```powershell
$env:FLUTTER_GIT_URL="https://mirrors.tuna.tsinghua.edu.cn/git/flutter-sdk.git"
$env:PUB_HOSTED_URL="https://pub.flutter-io.cn"
$env:FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
flutter upgrade
```

### 永続的な解決方法

**システム環境変数に設定**して、PowerShell を再起動後、`flutter upgrade` を実行。

### よくある問題と解決策の早見表

| 問題 | 解決策 |
| ---- | ------ |
| 環境変数エラー | `FLUTTER_GIT_URL` を設定 |
| アップグレードが失敗 | Git で直接管理する |
| プロジェクトでエラー | `flutter clean && flutter pub get` |
| リモート設定の問題 | `git remote set-url` で修正 |

## 参考資料

- [Flutter 公式ドキュメント - セットアップ](https://flutter.dev/docs/get-started/install)
- [Flutter 中国ミラーサイト](https://flutter.cn/)
- [Git リモート管理](https://git-scm.com/book/ja/v2/Git-%E3%81%AE%E5%9F%BA%E6%9C%AC-%E3%83%AA%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%AE%E5%8F%96%E5%BE%97)

