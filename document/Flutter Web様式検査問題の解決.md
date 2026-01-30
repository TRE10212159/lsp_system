# Flutter Web 样式审查问题の解決方法

## 問題の概要

Flutter Web アプリケーションをブラウザで実行した際、開発者ツールで「要素を検証」しても CSS スタイルを確認できない問題が発生しています。

## 原因分析

### Flutter Web のレンダリング方式

Flutter Web には以下のレンダリング方式があります：

1. **CanvasKit レンダラー**（デフォルト）

   - Skia グラフィックスエンジンを WebAssembly にコンパイルして使用
   - すべての UI を Canvas 要素上に描画
   - 標準的な HTML/CSS を生成しない
   - 高性能だが、ブラウザの開発者ツールで要素を検証できない

2. **HTML レンダラー**
   - HTML、CSS、Canvas、SVG を使用して UI を構築
   - 標準的な DOM 要素を生成
   - ブラウザの開発者ツールで要素を検証可能
   - ファイルサイズが小さい

### 現在の状況

Flutter 3.7 以降、CanvasKit がデフォルトのレンダラーとなっているため、**要素を検証してもスタイル情報を確認できません**。

## 解決方法

### 方法 1: プログラムでレンダラーを指定（推奨）

`web/index.html` ファイルを修正して、HTML レンダラーを使用するように設定します。

#### 現在の web/index.html の構造

```html
<!DOCTYPE html>
<html>
  <head>
    <base href="$FLUTTER_BASE_HREF" />
    <meta charset="UTF-8" />
    <!-- その他のメタタグ -->
    <title>lsp_system</title>
    <link
      rel="manifest"
      href="manifest.json"
    />
  </head>
  <body>
    <script
      src="flutter_bootstrap.js"
      async
    ></script>
  </body>
</html>
```

#### 修正方法

`flutter_bootstrap.js` の読み込み部分を以下のように修正します：

```html
<body>
  <script>
    // Flutter Web レンダラーを HTML モードに設定
    window.addEventListener('load', function (ev) {
      _flutter.loader.load({
        renderer: 'html', // HTML レンダラーを使用
        config: {
          canvasKitBaseUrl: '/canvaskit/'
        }
      });
    });
  </script>
  <script
    src="flutter.js"
    defer
  ></script>
</body>
```

### 方法 2: 開発環境での一時的な対処

開発モードで実行する際、Flutter は自動的に HTML レンダラーを使用することがあります。以下のコマンドで実行してください：

```bash
# Chrome で実行
flutter run -d chrome

# デバッグモードで実行
flutter run -d chrome --debug
```

### 方法 3: 環境変数を使用（古いバージョン）

Flutter 3.7 より前のバージョンでは、以下のコマンドが使用できました：

```bash
# 注意: 新しいバージョンでは使用できない可能性があります
flutter run -d chrome --web-renderer html
flutter build web --web-renderer html
```

## 各方式の比較

| 特徴             | CanvasKit    | HTML |
| ---------------- | ------------ | ---- |
| デフォルト       | ✓            | ✗    |
| 要素検証         | ✗            | ✓    |
| レンダリング品質 | 高           | 中   |
| パフォーマンス   | 高           | 中   |
| ファイルサイズ   | 大（約 2MB） | 小   |
| モバイル対応     | 良           | 良   |
| デスクトップ対応 | 優           | 良   |

## 推奨される対応方法

### 開発環境

- **HTML レンダラー** を使用
- スタイルのデバッグが容易
- ファイルサイズが小さく、リロードが速い

### 本番環境

- **CanvasKit レンダラー** を使用
- 高品質なレンダリング
- 一貫したパフォーマンス

## 実装手順

### ステップ 1: web/index.html を修正

1. `web/index.html` ファイルを開く
2. `<body>` タグ内のスクリプト部分を修正
3. HTML レンダラーを指定

### ステップ 2: アプリケーションを再起動

```bash
# 既存のプロセスを停止
# Ctrl+C でターミナルのプロセスを停止

# アプリケーションを再起動
flutter run -d chrome
```

### ステップ 3: ブラウザで確認

1. ブラウザの開発者ツールを開く（F12）
2. 「Elements」タブを選択
3. 要素を検証してスタイルを確認

## トラブルシューティング

### 問題: 修正後も要素を検証できない

**解決策**:

1. ブラウザのキャッシュをクリア（Ctrl+Shift+Delete）
2. Flutter の build フォルダを削除して再ビルド
   ```bash
   flutter clean
   flutter pub get
   flutter run -d chrome
   ```

### 問題: アプリケーションのパフォーマンスが低下した

**解決策**:

- HTML レンダラーは CanvasKit より若干パフォーマンスが低い場合があります
- 開発時は HTML レンダラーを使用し、本番ビルド時は CanvasKit を使用することを推奨します

### 問題: レンダリングの見た目が異なる

**解決策**:

- 両方のレンダラーでテストを実行
- レンダリングの差異がある場合は、Flutter の公式ドキュメントを参照
- 必要に応じてレンダラー固有のコードを記述

## 参考資料

- [Flutter Web レンダラー公式ドキュメント](https://docs.flutter.dev/platform-integration/web/renderers)
- [Flutter Web ビルドモード](https://docs.flutter.dev/deployment/web)
- [Web デバッグツール](https://docs.flutter.dev/tools/devtools/overview)

## 結論

Flutter Web で要素のスタイルを検証するには、**HTML レンダラー** を使用する必要があります。開発環境では HTML レンダラーを使用し、本番環境では CanvasKit レンダラーを使用することで、開発効率とアプリケーションのパフォーマンスの両方を最適化できます。
