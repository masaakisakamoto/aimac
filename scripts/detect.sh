#!/usr/bin/env bash

set -u

echo "AIMac Doctor"
echo "============"
echo

score=0
max_score=100

add_score() {
  score=$((score + $1))
}

print_ok() {
  echo "✔ $1"
}

print_warn() {
  echo "⚠ $1"
}

print_fail() {
  echo "✖ $1"
}

print_section() {
  echo
  echo "[$1]"
}

# --------------------------------------------------
# System
# --------------------------------------------------
print_section "System"

OS_NAME="$(sw_vers -productName 2>/dev/null || echo "Unknown")"
OS_VERSION="$(sw_vers -productVersion 2>/dev/null || echo "Unknown")"
ARCH="$(uname -m 2>/dev/null || echo "Unknown")"
SHELL_NAME="${SHELL:-unknown}"

echo "OS: $OS_NAME $OS_VERSION"
echo "Arch: $ARCH"
echo "Shell: $SHELL_NAME"

if [[ "$ARCH" == "arm64" ]]; then
  add_score 10
  print_ok "Apple Silicon detected"
else
  add_score 5
  print_warn "Non-Apple-Silicon or unknown architecture detected"
fi

# --------------------------------------------------
# Xcode Command Line Tools
# --------------------------------------------------
print_section "Prerequisites"

if xcode-select -p >/dev/null 2>&1; then
  add_score 10
  print_ok "Xcode Command Line Tools: installed"
else
  print_fail "Xcode Command Line Tools: missing"
fi

# --------------------------------------------------
# Homebrew
# --------------------------------------------------
if command -v brew >/dev/null 2>&1; then
  add_score 15
  BREW_PREFIX="$(brew --prefix 2>/dev/null || echo "unknown")"
  print_ok "Homebrew: installed ($BREW_PREFIX)"
else
  print_fail "Homebrew: missing"
fi

# --------------------------------------------------
# Core tools
# --------------------------------------------------
print_section "Core Tools"

if command -v git >/dev/null 2>&1; then
  add_score 10
  print_ok "Git: installed ($(git --version 2>/dev/null))"
else
  print_fail "Git: missing"
fi

if command -v python3 >/dev/null 2>&1; then
  add_score 10
  print_ok "Python: installed ($(python3 --version 2>/dev/null))"
else
  print_fail "Python: missing"
fi

if command -v node >/dev/null 2>&1; then
  add_score 10
  print_ok "Node: installed ($(node --version 2>/dev/null))"
else
  print_fail "Node: missing"
fi

if command -v docker >/dev/null 2>&1; then
  add_score 5
  print_ok "Docker: installed ($(docker --version 2>/dev/null))"
else
  print_warn "Docker: missing"
fi

# --------------------------------------------------
# AI / runtime managers
# --------------------------------------------------
print_section "AI / Runtime Managers"

if command -v mise >/dev/null 2>&1; then
  add_score 10
  print_ok "mise: installed ($(mise --version 2>/dev/null | head -n 1))"
else
  print_warn "mise: missing"
fi

if command -v uv >/dev/null 2>&1; then
  add_score 5
  print_ok "uv: installed ($(uv --version 2>/dev/null))"
else
  print_warn "uv: missing"
fi

if command -v ollama >/dev/null 2>&1; then
  add_score 5
  print_ok "Ollama: installed ($(ollama --version 2>/dev/null | head -n 1))"
else
  print_warn "Ollama: missing"
fi

# --------------------------------------------------
# Conflict detection
# --------------------------------------------------
print_section "Conflict Detection"

conflicts=0

if command -v nvm >/dev/null 2>&1; then
  conflicts=$((conflicts + 1))
  print_warn "nvm detected (possible overlap with mise)"
else
  print_ok "nvm: not detected"
fi

if command -v pyenv >/dev/null 2>&1; then
  conflicts=$((conflicts + 1))
  print_warn "pyenv detected (possible overlap with mise)"
else
  print_ok "pyenv: not detected"
fi

if command -v asdf >/dev/null 2>&1; then
  conflicts=$((conflicts + 1))
  print_warn "asdf detected (possible overlap with mise)"
else
  print_ok "asdf: not detected"
fi

# --------------------------------------------------
# Git config
# --------------------------------------------------
print_section "Developer Identity"

GIT_NAME="$(git config --global user.name || true)"
GIT_EMAIL="$(git config --global user.email || true)"

if [[ -n "$GIT_NAME" ]]; then
  add_score 3
  print_ok "git user.name: set ($GIT_NAME)"
else
  print_warn "git user.name: not set"
fi

if [[ -n "$GIT_EMAIL" ]]; then
  add_score 2
  print_ok "git user.email: set ($GIT_EMAIL)"
else
  print_warn "git user.email: not set"
fi

# --------------------------------------------------
# AI readiness result
# --------------------------------------------------
print_section "AI Readiness"

if (( score >= 80 )); then
  readiness="strong"
elif (( score >= 55 )); then
  readiness="partial"
else
  readiness="low"
fi

echo "Score: $score/$max_score"
echo "Status: $readiness"

if (( conflicts == 0 )); then
  print_ok "No major runtime-manager conflicts detected"
else
  print_warn "$conflicts possible runtime-manager conflict(s) detected"
fi

# --------------------------------------------------
# Next steps
# --------------------------------------------------
print_section "Next Steps"

if ! xcode-select -p >/dev/null 2>&1; then
  echo "1. Install Xcode Command Line Tools"
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "2. Install Homebrew"
fi

if ! command -v mise >/dev/null 2>&1; then
  echo "3. Install mise for runtime management"
fi

if ! command -v node >/dev/null 2>&1; then
  echo "4. Install Node.js"
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "5. Install Python 3"
fi

if ! command -v docker >/dev/null 2>&1; then
  echo "6. Install Docker Desktop if container workflows are needed"
fi

if [[ -z "$GIT_NAME" || -z "$GIT_EMAIL" ]]; then
  echo "7. Set git global identity"
fi

if (( conflicts > 0 )); then
  echo "8. Decide whether to keep existing runtime managers or standardize on mise"
fi

echo
echo "Doctor complete."
