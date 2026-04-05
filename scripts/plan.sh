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

echo "AIMac Plan"
echo "=========="
echo
echo "Profile: $PROFILE"
echo "Safe mode: $SAFE_MODE"
echo

install_items=()
upgrade_items=()
skip_items=()
conflict_items=()
manual_items=()

add_install() {
  install_items+=("$1")
}

add_upgrade() {
  upgrade_items+=("$1")
}

add_skip() {
  skip_items+=("$1")
}

add_conflict() {
  conflict_items+=("$1")
}

add_manual() {
  manual_items+=("$1")
}

# --------------------------------------------------
# Prerequisites
# --------------------------------------------------
if ! xcode-select -p >/dev/null 2>&1; then
  add_manual "Install Xcode Command Line Tools"
else
  add_skip "Xcode Command Line Tools already installed"
fi

if ! command -v brew >/dev/null 2>&1; then
  add_install "Homebrew"
else
  add_skip "Homebrew already installed"
fi

# --------------------------------------------------
# Core tools
# --------------------------------------------------
if ! command -v git >/dev/null 2>&1; then
  add_install "Git"
else
  add_skip "Git already installed"
fi

if ! command -v python3 >/dev/null 2>&1; then
  add_install "Python 3"
else
  add_skip "Python 3 already installed"
fi

if ! command -v node >/dev/null 2>&1; then
  add_install "Node.js"
else
  add_skip "Node.js already installed"
fi

if ! command -v docker >/dev/null 2>&1; then
  add_install "Docker Desktop"
else
  add_skip "Docker already installed"
fi

# --------------------------------------------------
# Runtime / AI tooling
# --------------------------------------------------
if ! command -v mise >/dev/null 2>&1; then
  add_install "mise"
else
  add_skip "mise already installed"
fi

if ! command -v uv >/dev/null 2>&1; then
  add_install "uv"
else
  add_skip "uv already installed"
fi

# --------------------------------------------------
# Profile-specific additions
# --------------------------------------------------
case "$PROFILE" in
  beginner)
    if ! command -v code >/dev/null 2>&1; then
      add_install "Visual Studio Code"
    else
      add_skip "Visual Studio Code CLI already available"
    fi
    ;;
  builder)
    if ! command -v code >/dev/null 2>&1; then
      add_install "Visual Studio Code"
    else
      add_skip "Visual Studio Code CLI already available"
    fi

    if ! command -v gh >/dev/null 2>&1; then
      add_install "GitHub CLI"
    else
      add_skip "GitHub CLI already installed"
    fi
    ;;
  local-ai)
    if ! command -v ollama >/dev/null 2>&1; then
      add_install "Ollama"
    else
      add_skip "Ollama already installed"
    fi
    ;;
  minimal)
    add_skip "Minimal profile selected: only missing essentials will be considered"
    ;;
  *)
    add_manual "Unknown profile: $PROFILE"
    ;;
esac

# --------------------------------------------------
# Conflict detection
# --------------------------------------------------
if command -v nvm >/dev/null 2>&1; then
  add_conflict "nvm detected (possible overlap with mise)"
fi

if command -v pyenv >/dev/null 2>&1; then
  add_conflict "pyenv detected (possible overlap with mise)"
fi

if command -v asdf >/dev/null 2>&1; then
  add_conflict "asdf detected (possible overlap with mise)"
fi

# --------------------------------------------------
# Git identity checks
# --------------------------------------------------
GIT_NAME="$(git config --global user.name || true)"
GIT_EMAIL="$(git config --global user.email || true)"

if [[ -z "$GIT_NAME" ]]; then
  add_manual "Set git global user.name"
fi

if [[ -z "$GIT_EMAIL" ]]; then
  add_manual "Set git global user.email"
fi

# --------------------------------------------------
# Output
# --------------------------------------------------
print_group_from_name() {
  local title="$1"
  local array_name="$2"

  echo "[$title]"

  eval "local count=\${#$array_name[@]}"

  if [ "$count" -eq 0 ]; then
    echo "- none"
  else
    eval "for item in \"\${$array_name[@]}\"; do echo \"- \$item\"; done"
  fi

  echo
}

print_group_from_name "Install" install_items
print_group_from_name "Upgrade" upgrade_items
print_group_from_name "Skip" skip_items
print_group_from_name "Conflicts" conflict_items
print_group_from_name "Manual Required" manual_items

echo "Plan complete."
