#!/bin/bash
set -e

FLUTTER_VERSION="3.41.6"
FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"

echo "==> Installing Flutter SDK ${FLUTTER_VERSION}..."
curl -sL "$FLUTTER_URL" | tar xJ -C /tmp
export PATH="/tmp/flutter/bin:$PATH"

echo "==> Flutter version:"
flutter --version

echo "==> Enabling web..."
flutter config --enable-web

echo "==> Getting dependencies..."
flutter pub get

echo "==> Building for web (release)..."
flutter build web --release

echo "==> Build complete! Output in build/web"
