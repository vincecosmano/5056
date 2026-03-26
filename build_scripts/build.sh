#!/usr/bin/env bash
# ============================================================
# build.sh – Builds Oneapptredie for both Web and Android APK
# ============================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "==> Project: $PROJECT_DIR"
cd "$PROJECT_DIR"

echo ""
echo "==== Step 1: Clean previous builds ===="
flutter clean

echo ""
echo "==== Step 2: Get dependencies ===="
flutter pub get

echo ""
echo "==== Step 3: Build Web (release) ===="
flutter build web --release
echo "Web build output: build/web/"

echo ""
echo "==== Step 4: Build Android APK (release) ===="
flutter build apk --release
echo "APK output: build/app/outputs/flutter-apk/app-release.apk"

echo ""
echo "==== Build Complete! ===="
echo "  Web:     build/web/"
echo "  Android: build/app/outputs/flutter-apk/app-release.apk"
