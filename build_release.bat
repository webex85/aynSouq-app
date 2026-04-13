@echo off
REM AynSouq Release Build Script for Windows
REM This script helps build release versions for Android

setlocal enabledelayedexpansion

echo ========================================
echo    AynSouq Release Build Script
echo ========================================
echo.

REM Check if Flutter is installed
where flutter >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Flutter is not installed or not in PATH
    exit /b 1
)

echo [OK] Flutter found
flutter --version | findstr /C:"Flutter"
echo.

REM Clean previous builds
echo Cleaning previous builds...
call flutter clean
if %errorlevel% neq 0 (
    echo [ERROR] Clean failed
    exit /b 1
)
echo [OK] Clean completed
echo.

REM Get dependencies
echo Getting dependencies...
call flutter pub get
if %errorlevel% neq 0 (
    echo [ERROR] Failed to get dependencies
    exit /b 1
)
echo [OK] Dependencies fetched
echo.

REM Generate icons and splash screens
echo Generating app icons and splash screens...
call flutter pub run flutter_launcher_icons
call flutter pub run flutter_native_splash:create
echo [OK] Icons and splash screens generated
echo.

REM Build selection
echo Select build type:
echo 1) Android APK
echo 2) Android App Bundle (AAB) - Recommended for Play Store
echo 3) Exit
echo.
set /p choice="Enter your choice (1-3): "

if "%choice%"=="1" (
    echo.
    echo Building Android APK...
    call flutter build apk --release
    if %errorlevel% neq 0 (
        echo [ERROR] Build failed
        exit /b 1
    )
    echo.
    echo [OK] Android APK built successfully!
    echo Location: build\app\outputs\flutter-apk\app-release.apk
) else if "%choice%"=="2" (
    echo.
    
    REM Check if key.properties exists
    if not exist "android\key.properties" (
        echo [WARNING] android\key.properties not found!
        echo The app will be signed with debug keys.
        echo For production release, create key.properties from key.properties.template
        set /p continue="Continue anyway? (y/n): "
        if /i not "!continue!"=="y" exit /b 1
    )
    
    echo Building Android App Bundle...
    call flutter build appbundle --release
    if %errorlevel% neq 0 (
        echo [ERROR] Build failed
        exit /b 1
    )
    echo.
    echo [OK] Android App Bundle built successfully!
    echo Location: build\app\outputs\bundle\release\app-release.aab
) else if "%choice%"=="3" (
    echo Exiting...
    exit /b 0
) else (
    echo [ERROR] Invalid choice
    exit /b 1
)

echo.
echo ========================================
echo [OK] Build process completed!
echo ========================================
echo.
echo Next steps:
echo 1. Test the release build on physical devices
echo 2. Review DEPLOYMENT_GUIDE.md for upload instructions
echo 3. Upload to Google Play Store
echo.

pause
