# Flutter プロジェクトの Makefile

.PHONY: help web web-chrome web-edge clean build-web install test format analyze kill

# ヘルプメッセージを表示
help:
	@echo "利用可能なコマンド:"
	@echo "  make web          - Web Server モードで起動 (http://localhost:8080)"
	@echo "  make web-chrome   - Chrome ブラウザで起動"
	@echo "  make web-edge     - Edge ブラウザで起動"
	@echo "  make clean        - ビルドキャッシュをクリア"
	@echo "  make build-web    - 本番用に Web アプリをビルド"
	@echo "  make install      - 依存関係をインストール"
	@echo "  make test         - テストを実行"
	@echo "  make format       - コードをフォーマット"
	@echo "  make analyze      - コードを分析"
	@echo "  make kill         - 8080 ポートのプロセスを終了"

# Web Server モードで起動
web:
	flutter run -d web-server --web-port=8080 html

# Chrome で起動
web-chrome:
	flutter run -d chrome

# Edge で起動
web-edge:
	flutter run -d edge

# ビルドキャッシュをクリア
clean:
	flutter clean
	flutter pub get

# 本番用にビルド
build-web:
	flutter build web --release

# 依存関係をインストール
install:
	flutter pub get

# テストを実行
test:
	flutter test

# コードをフォーマット
format:
	dart format .

# コードを分析
analyze:
	flutter analyze

# 開発用のクリーンビルド
rebuild: clean install web

# Riverpod のコード生成
generate:
	dart run build_runner build --delete-conflicting-outputs

# Riverpod のコード生成（監視モード）
watch:
	dart run build_runner watch --delete-conflicting-outputs

# 8080 ポートのプロセスを終了
kill:
	@echo "Killing process on port 8080..."
	@for /f "tokens=5" %%a in ('netstat -ano ^| findstr :8080') do taskkill /PID %%a /F

