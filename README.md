# LSP System

労働力管理システム（Labor Service Planning System）

## 概要

LSP System は、Flutter で構築されたクロスプラットフォーム対応の労働力管理システムです。
作業計画、進捗管理、分析レポートなど、包括的な労働力管理機能を提供します。

## 対応プラットフォーム

- ✅ Web (Chrome, Firefox, Safari, Edge)
- ✅ Android (API 21+)
- ✅ iOS (iOS 12+)
- ✅ Windows (Windows 10+)
- ✅ macOS (macOS 10.14+)
- ✅ Linux (Ubuntu 20.04+)

## 技術スタック

- **Flutter**: 3.7.2+
- **Dart**: 3.7.2+
- **go_router**: 14.6.2
- **Riverpod**: 2.6.1
- **SharedPreferences**: 2.3.3

## セットアップ

### 必要な環境

- Flutter SDK 3.7.2 以上
- Dart SDK 3.7.2 以上

### インストール手順

1. リポジトリをクローン

```bash
git clone <repository-url>
cd lsp_system
```

2. 依存関係をインストール

```bash
flutter pub get
```

3. コード生成を実行

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 起動方法

### 🚀 クイックスタート（推奨）

**最も簡単な方法:**

```cmd
# Web Server モードで起動
.\dev.bat web
```

ブラウザで `http://localhost:8080` を開く

**またはダブルクリック:**

`run.bat` をダブルクリックして起動

### その他の起動方法

**Makefile を使用:**

```bash
make web          # Web Server モード
make web-chrome   # Chrome で起動
make help         # すべてのコマンドを表示
```

**PowerShell を使用:**

```powershell
.\scripts\dev.ps1 web       # Web Server モード
.\scripts\dev.ps1 chrome    # Chrome で起動
```

**VS Code を使用:**

1. `Ctrl + Shift + P` を押す
2. "Tasks: Run Task" を選択
3. "Flutter: Web Server で起動" を選択

**従来の Flutter コマンド:**

```bash
# Web Server モード（推奨）
flutter run -d web-server --web-port=8080

# Chrome で起動
flutter run -d chrome
```

### Windows

```bash
flutter run -d windows
```

### モバイル (デバイスまたはエミュレーターが必要)

```bash
flutter run
```

### 📋 すべてのコマンド

詳細は以下を参照:

- **[COMMANDS.md](COMMANDS.md)** - 簡潔なコマンドリファレンス
- **[QUICK_START.md](QUICK_START.md)** - 詳細なクイックスタートガイド

## ログイン情報

開発環境用のテストアカウント：

- **ユーザー名**: `admin`
- **パスワード**: `admin`

## UI構造

### サイドバーナビゲーション

- 左側固定サイドバー（デスクトップ）
- ドロワーメニュー（モバイル）
- 展開可能な階層メニュー
- 現在ページのハイライト表示

### シングルページアプリケーション（SPA）

- URL変更による直接アクセス可能
- ブラウザの戻る/進むボタン対応
- ページ遷移時もサイドバーを維持

## 主な機能

### 労働力計画

- 必要人時予測
- 稼働計画
- 作業割当

### 作業管理

- 作業モデル管理
- 作業実績進捗管理（展開メニュー）
  - 個人作業実績管理
  - MGR 作業進捗管理
  - 作業完了率

### 分析機能（展開メニュー）

- 予算計画実績契約分析
- 必要人時と契約差異分析
- 人時生産性

### 個人サービス（展開メニュー）

- 個人計画修正
- 希望休みや希望時間申請
- 有給・時間変更申請
- 応募

## プロジェクト構造

```
lib/
├── main.dart                 # エントリーポイント
├── app.dart                  # ルートウィジェット
├── router/                   # ルーティング設定
├── features/                 # 機能モジュール
├── shared/                   # 共有コンポーネント
└── core/                     # コア機能
```

詳細は [プロジェクトアーキテクチャ](document/プロジェクトアーキテクチャ.md) を参照してください。

## ドキュメント

### クイックスタート

- **[COMMANDS.md](COMMANDS.md)** - コマンドクイックリファレンス
- **[QUICK_START.md](QUICK_START.md)** - 詳細なクイックスタートガイド

### 開発ガイド

- [開発用コマンド一覧](document/開発用コマンド一覧.md)
- [Flutter Web起動問題の解決方法](document/Flutter%20Web起動問題の解決方法.md)
- [Flutter Web様式検査問題の解決](document/Flutter%20Web様式検査問題の解決.md)

### アーキテクチャ

- [プロジェクトアーキテクチャ](document/プロジェクトアーキテクチャ.md)
- [ルーティング設定書](document/ルーティング設定書.md)
- [実装完了報告書](document/実装完了報告書.md)
- [サイドバーナビゲーション実装報告書](document/サイドバーナビゲーション実装報告書.md)

## 開発

### クイックコマンド

```cmd
.\dev.bat web       # Web 起動
.\dev.bat clean     # クリーン
.\dev.bat build     # ビルド
.\dev.bat generate  # コード生成
.\dev.bat watch     # コード生成監視
```

または Makefile を使用:

```bash
make web       # Web 起動
make clean     # クリーン
make build-web # ビルド
make generate  # コード生成
make watch     # コード生成監視
make analyze   # コード分析
make format    # フォーマット
```

### コード生成

Riverpod のコード生成を実行:

```bash
.\dev.bat generate
# または
flutter pub run build_runner build --delete-conflicting-outputs
```

監視モードで自動生成:

```bash
.\dev.bat watch
# または
flutter pub run build_runner watch --delete-conflicting-outputs
```

### コード品質チェック

```bash
make analyze
# または
flutter analyze
```

### フォーマット

```bash
make format
# または
dart format lib/
```

## ビルド

### Web

```bash
flutter build web
```

### Windows

```bash
flutter build windows
```

### Android

```bash
flutter build apk
```

### iOS

```bash
flutter build ios
```

## ライセンス

このプロジェクトはプライベートプロジェクトです。

## サポート

問題や質問がある場合は、プロジェクトの Issue セクションで報告してください。
