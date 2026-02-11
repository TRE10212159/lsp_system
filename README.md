# LSP System

Flutter 製の**人材・稼働計画システム**。**Web** と **Android** 向けにビルドし、必要人時予測・稼働計画・作業割当・進捗管理・個人サービスなどを提供します。

---

## 機能モジュール

| モジュール       | 説明                                                         |
| ---------------- | ------------------------------------------------------------ |
| **認証**         | ログインと認証                                               |
| **ホーム**       | メインナビゲーションとウェルカム画面                         |
| **人力計画**     | 必要人時予測、稼働計画、作業割当                             |
| **作業モデル**   | 作業モデル管理                                               |
| **進捗管理**     | 個人作業実績、MGR 作業進捗、作業完了率                       |
| **分析レポート** | 予算計画実績契約分析、必要人時と契約差異、人時生産性         |
| **個人サービス** | 個人計画修正、希望休・希望時間申請、有給・時間変更申請、応募 |

---

## 技術スタック

- **フレームワーク**: Flutter（SDK ^3.7.2）
- **ルーティング**: [go_router](https://pub.dev/packages/go_router) ^14.6.2
- **状態管理**: [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) + [riverpod_annotation](https://pub.dev/packages/riverpod_annotation)。`build_runner` / `riverpod_generator` によるコード生成を利用
- **ローカルストレージ**: [shared_preferences](https://pub.dev/packages/shared_preferences)
- **コード規約**: `flutter_lints`、`riverpod_lint`

---

## 環境要件

- [Flutter](https://flutter.dev) 3.7.2 以上（Dart 3.7.2+ 含む）
- 任意: Android Studio / VS Code + Flutter 拡張で開発・デバッグ

---

## インストールと実行

### 1. リポジトリのクローンと移動

```bash
git clone <repository-url>
cd lsp_system
```

### 2. 依存関係のインストール

```bash
flutter pub get
```

### 3. コード生成（Riverpod / Router など）

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. プロジェクトの起動

**推奨**: Chrome でポート **8080** を指定して起動します。

```bash
flutter run -d chrome --web-port 8080
```

起動後、ブラウザで **http://localhost:8080** にアクセスするとアプリが表示されます。

Android で実行する場合:

```bash
flutter run -d android
```

### 5. Dart DevTools でのデバッグ

アプリ起動後、以下のいずれかの方法で Dart DevTools を開いてデバッグできます。

#### 方法 A: ターミナルに表示される URL から開く（最も簡単）

1. `flutter run -d chrome --web-port 8080` でアプリを起動する。
2. ターミナルに次のようなメッセージが表示される:
   ```text
   The Flutter DevTools debugger and profiler on Chrome is available at: http://127.0.0.1:xxxxx/...
   ```
3. その **URL をブラウザで開く**と Dart DevTools が起動する。
4. DevTools では **Inspector**（ウィジェットツリー）、**Performance**、**Network**、**Logging** などでデバッグ可能。

#### 方法 B: 別ターミナルから `dart devtools` で接続する

1. アプリを `flutter run -d chrome --web-port 8080` で起動したままにする。
2. **別のターミナル**で以下を実行:
   ```bash
   dart devtools
   ```
3. デフォルトでブラウザが開き、DevTools の画面が表示される。  
   「**Connect**」または「**アプリを選択**」から、実行中の **Chrome (lsp_system)** を選ぶ。
4. 接続されると、同じく Inspector / Performance / Network などでデバッグできる。

#### 方法 C: VS Code / Cursor から開く

1. アプリを F5 または「デバッグの開始」で起動している場合、**デバッグツールバー**に「**Dart: Open DevTools**」または「**Flutter: Open DevTools**」が表示されることがある。
2. それをクリックするか、コマンドパレット（`Ctrl+Shift+P`）で「**Flutter: Open DevTools**」を実行する。
3. 実行中のアプリに自動で接続され、DevTools が開く。

#### DevTools でよく使う機能

| 機能            | 用途                                                 |
| --------------- | ---------------------------------------------------- |
| **Inspector**   | ウィジェットツリーの確認、レイアウト・スタイルの検証 |
| **Performance** | フレームレート、CPU 使用率、タイムライン計測         |
| **Network**     | Web 版での HTTP リクエストの確認                     |
| **Logging**     | `debugPrint` / `print` のログ確認                    |

### 6. ビルド成果物

```bash
# Web ビルド
flutter build web

# Android ビルド（APK）
flutter build apk
```

成果物は **Web** が `build/web`、**Android** が `build/app/outputs/flutter-apk/` に出力されます。

---

## プロジェクト構成

```
lib/
├── main.dart               # アプリケーションエントリーポイント、ProviderScope
├── app.dart                # ルートウィジェット、認証と MaterialApp.router
├── router/                 # go_router 設定とルート定義
├── core/                   # コアサービス（storage など）
├── shared/                 # 共通定数、テーマ、共通ウィジェット（Scaffold、サイドバーなど）
└── features/               # 機能別モジュール
    ├── auth/               # ログイン、ユーザーモデル、認証 Provider
    ├── home/               # ホーム
    ├── workforce_planning/ # 人力計画（予測、稼働計画、作業割当）
    ├── work_model/         # 作業モデル
    ├── progress/           # 進捗（個人 / MGR / 完了率）
    ├── analytics/          # 分析（予算、差異、生産性）
    └── personal/           # 個人サービス（計画修正、休暇・時間申請、応募）
```

---

## 開発上の注意

- **ドキュメント**: プロジェクト関連ドキュメントは `./document` に格納する。
- **コメントとコミット**: リポジトリルートの `.cursorrules` を参照（コメント規約、Conventional Commits など）。
- **静的解析**: `analysis_options.yaml` で `flutter_lints` を有効化済み。コミット前に以下を実行することを推奨します。

  ```bash
  flutter analyze
  ```

---

## バージョン

現在のバージョン: **1.0.0+1**（`pubspec.yaml` に準拠）。

---

## ライセンス

本プロジェクトはプライベートリポジトリであり、pub.dev には公開していません（`publish_to: 'none'`）。利用・再配布は所属組織のライセンスに従ってください。
