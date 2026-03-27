#!/usr/bin/env bash
# ============================================================
# build_apk.sh – Builds the Android APK only
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
echo "==== Step 3: Build Android APK (release) ===="
flutter build apk --release

APK_PATH="$PROJECT_DIR/build/app/outputs/flutter-apk/app-release.apk"
echo ""
echo "==== APK Build Complete! ===="
echo "  APK: $APK_PATH"
echo ""
echo "To install directly on a connected device:"
echo "  adb install $APK_PATH"
