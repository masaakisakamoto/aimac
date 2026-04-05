#!/usr/bin/env bash

set -u

PROFILE="beginner"
SAFE_MODE="false"

for arg in "$@"; do
  case "$arg" in
    --profile=*)
      PROFILE="${arg#*=}"
      ;;
    --safe)
      SAFE_MODE="true"
      ;;
  esac
done

PROFILE_FILE="profiles/${PROFILE}.yaml"

echo "AIMac Apply"
echo "==========="
echo
echo "Profile: $PROFILE"
echo "Safe mode: $SAFE_MODE"
echo

if [[ ! -f "$PROFILE_FILE" ]]; then
  echo "Profile file not found: $PROFILE_FILE"
  exit 1
fi

profile_has_formula() {
  local formula="$1"
  grep -A20 '^formulas:' "$PROFILE_FILE" | grep -q "^- $formula\|^  - $formula"
}

profile_has_cask() {
  local cask="$1"
  grep -A20 '^casks:' "$PROFILE_FILE" | grep -q "^- $cask\|^  - $cask"
}

install_brew_formula() {
  local formula="$1"
  if command -v brew >/dev/null 2>&1; then
    echo "Installing formula: $formula"
    brew install "$formula"
  else
    echo "Homebrew is missing. Cannot install formula: $formula"
    return 1
  fi
}

install_brew_cask() {
  local cask="$1"
  if command -v brew >/dev/null 2>&1; then
    echo "Installing cask: $cask"
    brew install --cask "$cask"
  else
    echo "Homebrew is missing. Cannot install cask: $cask"
    return 1
  fi
}

ensure_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    echo "✔ Homebrew already installed"
  else
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

# --------------------------------------------------
# Prerequisites
# --------------------------------------------------
if xcode-select -p >/dev/null 2>&1; then
  echo "✔ Xcode Command Line Tools already installed"
else
  echo "Xcode Command Line Tools are missing."
  echo "Please run: xcode-select --install"
  echo "Apply stopped: manual prerequisite required."
  exit 1
fi

ensure_homebrew

# --------------------------------------------------
# Core tools
# --------------------------------------------------
if command -v git >/dev/null 2>&1; then
  echo "✔ Git already installed"
else
  install_brew_formula git
fi

if command -v python3 >/dev/null 2>&1; then
  echo "✔ Python 3 already installed"
else
  install_brew_formula python
fi

if command -v node >/dev/null 2>&1; then
  echo "✔ Node.js already installed"
else
  install_brew_formula node
fi

if command -v docker >/dev/null 2>&1; then
  echo "✔ Docker already installed"
else
  install_brew_cask docker
fi

# --------------------------------------------------
# Profile-driven formulas
# --------------------------------------------------
if profile_has_formula "mise"; then
  if command -v mise >/dev/null 2>&1; then
    echo "✔ mise already installed"
  else
    install_brew_formula mise
  fi
fi

if profile_has_formula "uv"; then
  if command -v uv >/dev/null 2>&1; then
    echo "✔ uv already installed"
  else
    install_brew_formula uv
  fi
fi

# --------------------------------------------------
# Profile-driven casks
# --------------------------------------------------
if profile_has_cask "visual-studio-code"; then
  if command -v code >/dev/null 2>&1; then
    echo "✔ Visual Studio Code CLI already available"
  else
    install_brew_cask visual-studio-code
    echo "Note: you may still need to enable the 'code' command from VS Code."
  fi
fi

# --------------------------------------------------
# Git identity reminder
# --------------------------------------------------
GIT_NAME="$(git config --global user.name || true)"
GIT_EMAIL="$(git config --global user.email || true)"

if [[ -z "$GIT_NAME" || -z "$GIT_EMAIL" ]]; then
  echo
  echo "Manual step recommended:"
  echo "  git config --global user.name \"Your Name\""
  echo "  git config --global user.email \"you@example.com\""
fi

echo
echo "Apply complete."
