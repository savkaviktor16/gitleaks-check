#!/bin/bash
set -e

# Check if gitleaks is installed
if ! command -v gitleaks &> /dev/null; then
  echo "Gitleaks not found. Installing..."

  curl -sSfL https://raw.githubusercontent.com/savkaviktor16/gitleaks-check/main/install-gitleaks-crossplatform.sh | sh

  # Check again if installed
  if ! command -v gitleaks &> /dev/null; then
    echo "Gitleaks installation failed. Please install manually: https://github.com/zricethezav/gitleaks/releases"
    exit 1
  fi
fi

echo "🚀 Installing Gitleaks pre-commit hook..."

# Check if current directory is a Git repository
if [ ! -d .git ]; then
  echo "❌ Current directory is not a Git repository!"
  echo "➡️ Please initialize a Git repository first or navigate to an existing one:"
  echo "   git init"
  exit 1
fi

# Create the .githooks directory
mkdir -p .githooks

# Download the pre-commit hook script from GitHub
curl -sSfL https://raw.githubusercontent.com/savkaviktor16/gitleaks-check/main/gitleaks-pre-commit -o .githooks/pre-commit

# Make the hook script executable
chmod +x .githooks/pre-commit

# Remove any existing pre-commit hook
rm -f .git/hooks/pre-commit

# Create a symbolic link to the new pre-commit hook
ln -s ../../.githooks/pre-commit .git/hooks/pre-commit

echo "✅ Pre-commit hook installed successfully!"
echo "📌 To run Gitleaks before every commit, enable it with <git config gitleaks.enable true> first"