@echo off
REM Quick development commands

if "%1"=="" goto help
if "%1"=="web" goto web
if "%1"=="chrome" goto chrome
if "%1"=="edge" goto edge
if "%1"=="clean" goto clean
if "%1"=="build" goto build
if "%1"=="install" goto install
if "%1"=="generate" goto generate
if "%1"=="watch" goto watch
if "%1"=="kill" goto kill
goto help

:web
echo Starting Flutter Web (Web Server mode)...
echo URL: http://localhost:8080
flutter run -d web-server --web-port=8080
goto end

:chrome
echo Starting Flutter Web (Chrome)...
echo Cleaning port 8080 if in use...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :8080 2^>nul') do (
    taskkill /PID %%a /F >nul 2>&1
)
echo Starting Flutter web server on port 8080...
flutter run -d chrome --web-port=8080
goto end

:edge
echo Starting Flutter Web (Edge)...
echo Cleaning port 8080 if in use...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :8080 2^>nul') do (
    taskkill /PID %%a /F >nul 2>&1
)
echo Starting Flutter web server on port 8080...
flutter run -d edge --web-port=8080
goto end

:clean
echo Cleaning build cache...
flutter clean
flutter pub get
echo Done!
goto end

:build
echo Building web app...
flutter build web --release
echo Build complete: build\web\
goto end

:install
echo Installing dependencies...
flutter pub get
echo Installation complete!
goto end

:generate
echo Generating Riverpod code...
dart run build_runner build --delete-conflicting-outputs
echo Code generation complete!
goto end

:watch
echo Watching for Riverpod code changes...
dart run build_runner watch --delete-conflicting-outputs
goto end

:kill
echo Killing process on port 8080...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :8080') do (
    taskkill /PID %%a /F
    echo Process terminated successfully!
    goto end
)
echo No process found on port 8080
goto end

:help
echo Usage: dev.bat [command]
echo.
echo Available commands:
echo   web       - Start Web Server mode (http://localhost:8080)
echo   chrome    - Start with Chrome
echo   edge      - Start with Edge
echo   clean     - Clean build cache
echo   build     - Build for production
echo   install   - Install dependencies
echo   generate  - Generate Riverpod code
echo   watch     - Watch for Riverpod code changes
echo   kill      - Kill process on port 8080
echo.
echo Example: dev.bat web
goto end

:end

