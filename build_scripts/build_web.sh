#!/usr/bin/env bash
# ============================================================
# build_web.sh – Builds the Flutter web version only
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

echo ""
echo "==== Web Build Complete! ===="
echo "  Output: $PROJECT_DIR/build/web/"
echo ""
echo "To serve locally:"
echo "  cd $PROJECT_DIR/build/web && python3 -m http.server 8080"
echo "  Then open http://localhost:8080 in your browser"
