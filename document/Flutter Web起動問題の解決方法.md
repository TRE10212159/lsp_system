# Flutter Web 起動問題の解決方法

## 問題の症状

`flutter run -d chrome` コマンドを実行した際に、以下のエラーが発生する：

- ブラウザが起動しない
- "無法訪問此網站"（このウェブサイトにアクセスできません）のエラー
- `http://localhost:3729/` にアクセスできない

## エラーメッセージ

```
Failed to launch browser after 3 tries.
Failed to launch browser. Make sure you are using an up-to-date Chrome or Edge.
```

## 原因分析

### 主な原因

1. **Chrome プロセスの競合**

   - Chrome が既に実行中で、Flutter が新しいインスタンスを起動できない
   - Chrome のデバッグポートが占有されている

2. **ポートの競合**

   - 指定されたポート（例：3729）が既に使用されている
   - ファイアウォールがポートをブロックしている

3. **Chrome の権限問題**

   - Chrome が適切な権限で実行されていない
   - ユーザーデータディレクトリへのアクセス権限がない

4. **一時ファイルの問題**
   - Flutter の一時ファイルが破損している
   - Chrome のプロファイルディレクトリが破損している

## 解決方法

### 方法 1: Web Server モードを使用（最も推奨）

Flutter の web-server モードを使用し、手動でブラウザを開く方法：

#### ステップ 1: Web Server モードで起動

```bash
flutter run -d web-server --web-port=8080
```

#### ステップ 2: ブラウザで開く

サーバーが起動したら、ブラウザで以下の URL を開く：

```
http://localhost:8080
```

#### メリット

- ブラウザの自動起動に関する問題を回避
- 任意のブラウザを使用可能
- デバッグしやすい
- より安定している

### 方法 2: Chrome を完全に閉じてから再試行

#### ステップ 1: Chrome を完全に終了

**タスクマネージャーを使用：**

1. `Ctrl + Shift + Esc` でタスクマネージャーを開く
2. "Google Chrome" のすべてのプロセスを探す
3. 各プロセスを選択して「タスクの終了」をクリック

**コマンドラインを使用：**

```bash
taskkill /F /IM chrome.exe
```

#### ステップ 2: Flutter を再起動

```bash
flutter run -d chrome
```

### 方法 3: 別のポートを指定

デフォルトのポートが使用中の場合、別のポートを指定：

```bash
flutter run -d web-server --web-port=3000
```

その後、`http://localhost:3000` をブラウザで開く。

### 方法 4: Flutter のキャッシュをクリア

#### ステップ 1: Flutter をクリーン

```bash
flutter clean
```

#### ステップ 2: 依存関係を再取得

```bash
flutter pub get
```

#### ステップ 3: 再起動

```bash
flutter run -d web-server --web-port=8080
```

### 方法 5: Edge ブラウザを使用

Chrome の代わりに Microsoft Edge を使用：

```bash
flutter run -d edge
```

### 方法 6: ホスト名を変更

localhost の代わりに IP アドレスを使用：

```bash
flutter run -d web-server --web-hostname=0.0.0.0 --web-port=8080
```

その後、`http://127.0.0.1:8080` または `http://0.0.0.0:8080` をブラウザで開く。

## 使用可能なデバイスを確認

どのデバイスが利用可能か確認：

```bash
flutter devices
```

出力例：

```
Chrome (web) • chrome • web-javascript • Google Chrome 120.0.6099.109
Edge (web) • edge • web-javascript • Microsoft Edge 120.0.2210.77
Web Server (web) • web-server • web-javascript • Flutter Tools
```

## 推奨される開発ワークフロー

### 日常の開発作業

1. **Web Server モードで起動：**

```bash
flutter run -d web-server --web-port=8080
```

2. **ブラウザで開く：**

   - `http://localhost:8080` を任意のブラウザで開く
   - ブックマークに追加して簡単にアクセス

3. **ホットリロード：**
   - ターミナルで `r` を押してホットリロード
   - `R` を押してホットリスタート

### デバッグ作業

Chrome DevTools を使用してデバッグ：

1. ブラウザで `F12` を押して開発者ツールを開く
2. Console タブでエラーを確認
3. Elements タブで HTML レンダラーの要素を検証
4. Network タブでリクエストを確認

## トラブルシューティング

### 問題: ポートが既に使用中

**エラー:**

```
Port 8080 is already in use
```

**解決策:**

1. 使用中のポートを確認：

```bash
netstat -ano | findstr :8080
```

2. プロセスを終了するか、別のポートを使用：

```bash
flutter run -d web-server --web-port=8081
```

### 問題: ホットリロードが動作しない

**解決策:**

1. `R`（大文字）を押してホットリスタートを実行
2. 完全に再起動：
   - ターミナルで `q` を押して終了
   - `flutter run -d web-server --web-port=8080` を再実行

### 問題: スタイルが適用されていない

**解決策:**

1. ブラウザのキャッシュをクリア（`Ctrl + Shift + Delete`）
2. Flutter をクリーン：

```bash
flutter clean
flutter pub get
flutter run -d web-server --web-port=8080
```

3. `web/index.html` で HTML レンダラーが設定されているか確認

### 問題: Chrome DevTools でエラーが表示される

**一般的なエラー:**

- `Failed to load resource`: ファイルパスまたはアセットの問題
- `ReferenceError`: JavaScript のエラー
- `SyntaxError`: コードの構文エラー

**解決策:**

1. エラーメッセージを読んで該当するファイルを確認
2. `flutter clean && flutter pub get` を実行
3. コードの構文エラーを修正

## 本番環境のビルド

開発が完了したら、本番用にビルド：

### CanvasKit レンダラー（デフォルト）

```bash
flutter build web
```

### HTML レンダラー

現在の `web/index.html` には HTML レンダラーの設定が含まれているため、そのままビルド可能：

```bash
flutter build web
```

ビルドされたファイルは `build/web/` ディレクトリに生成されます。

### 本番環境用に CanvasKit に戻す場合

`web/index.html` から以下のコードを削除：

```javascript
window.flutterConfiguration = {
  renderer: 'html'
};
```

## VS Code 統合（オプション）

VS Code を使用している場合、launch.json を設定：

### .vscode/launch.json

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Flutter Web (Server)",
      "request": "launch",
      "type": "dart",
      "args": ["-d", "web-server", "--web-port=8080"]
    },
    {
      "name": "Flutter Web (Chrome)",
      "request": "launch",
      "type": "dart",
      "args": ["-d", "chrome"]
    }
  ]
}
```

この設定により、VS Code のデバッグパネルから簡単に起動できます。

## まとめ

### 開発環境での推奨設定

1. **起動コマンド:**

   ```bash
   flutter run -d web-server --web-port=8080
   ```

2. **アクセス URL:**

   ```
   http://localhost:8080
   ```

3. **レンダラー:**

   - HTML レンダラー（`web/index.html` で設定済み）
   - スタイル検証が可能

4. **利点:**
   - 安定した起動
   - 任意のブラウザを使用可能
   - 開発者ツールでのデバッグが容易
   - ホットリロード対応

### よくある問題と解決策の早見表

| 問題                 | 解決策                                  |
| -------------------- | --------------------------------------- |
| ブラウザが起動しない | `web-server` モードを使用               |
| ポート競合           | `--web-port=別のポート` を指定          |
| スタイル検証できない | `web/index.html` で HTML レンダラー設定 |
| ホットリロードが遅い | `R` でホットリスタート                  |
| キャッシュ問題       | `flutter clean` を実行                  |

## 参考資料

- [Flutter Web デバッグ](https://docs.flutter.dev/platform-integration/web/debugging)
- [Flutter コマンドラインツール](https://docs.flutter.dev/reference/flutter-cli)
- [Web レンダラー](https://docs.flutter.dev/platform-integration/web/renderers)
