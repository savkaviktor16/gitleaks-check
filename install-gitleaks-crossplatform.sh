#!/bin/bash
set -e

VERSION=8.27.2
UNAMES="$(uname -s)"
COMPRESSION_FORMAT="tar.gz"

case "${UNAMES}" in
    Linux*)     OS=linux;;
    Darwin*)    OS=darwin;;
    MINGW*|MSYS*|CYGWIN*) OS=windows COMPRESSION_FORMAT="zip";;
esac

UNAMEM="$(uname -m)"
case "${UNAMEM}" in
    arm64*)     ARCH=arm64;;
    x86_64*)    ARCH=x64;;
esac

FILENAME="gitleaks_${VERSION}_${OS}_${ARCH}.${COMPRESSION_FORMAT}"

curl https://github.com/zricethezav/gitleaks/releases/download/v${VERSION}/${FILENAME} -L -O

if [ "$COMPRESSION_FORMAT" = "tar.gz" ]; then
    tar -xzf "$FILENAME" gitleaks
elif [ "$COMPRESSION_FORMAT" = "zip" ]; then
    unzip -q "$FILENAME" gitleaks.exe -d .
fi

rm ${FILENAME}

mkdir -p "$HOME/bin"

if [ "$OS" = "windows" ]; then
    mv gitleaks.exe "$HOME/bin/gitleaks.exe"
else
    mv gitleaks "$HOME/bin/gitleaks"
    chmod +x "$HOME/bin/gitleaks"
fi

case "$SHELL" in
    */zsh)   SHELL_RC="$HOME/.zshrc" ;;
    */bash)  SHELL_RC="$HOME/.bashrc" ;;
    *)       SHELL_RC="$HOME/.profile" ;;
esac

if ! grep -q 'export PATH="$HOME/bin:$PATH"' "$SHELL_RC"; then
  echo 'export PATH="$HOME/bin:$PATH"' >> "$SHELL_RC"
  echo "Added PATH export to $SHELL_RC"
else
  echo "PATH already set in $SHELL_RC"
fi

echo "Installation complete. Run 'gitleaks version' to verify."