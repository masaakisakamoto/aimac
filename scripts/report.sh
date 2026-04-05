#!/usr/bin/env bash

set -u

mkdir -p artifacts

TIMESTAMP="$(date +"%Y%m%d-%H%M%S")"
REPORT_FILE="artifacts/report-${TIMESTAMP}.md"

OS_NAME="$(sw_vers -productName 2>/dev/null || echo "Unknown")"
OS_VERSION="$(sw_vers -productVersion 2>/dev/null || echo "Unknown")"
ARCH="$(uname -m 2>/dev/null || echo "Unknown")"

BREW_STATUS="missing"
GIT_STATUS="missing"
PYTHON_STATUS="missing"
NODE_STATUS="missing"
DOCKER_STATUS="missing"
MISE_STATUS="missing"
UV_STATUS="missing"
OLLAMA_STATUS="missing"

BREW_DETAIL=""
GIT_DETAIL=""
PYTHON_DETAIL=""
NODE_DETAIL=""
DOCKER_DETAIL=""
MISE_DETAIL=""
UV_DETAIL=""
OLLAMA_DETAIL=""

if command -v brew >/dev/null 2>&1; then
  BREW_STATUS="installed"
  BREW_DETAIL="$(brew --prefix 2>/dev/null || true)"
fi

if command -v git >/dev/null 2>&1; then
  GIT_STATUS="installed"
  GIT_DETAIL="$(git --version 2>/dev/null || true)"
fi

if command -v python3 >/dev/null 2>&1; then
  PYTHON_STATUS="installed"
  PYTHON_DETAIL="$(python3 --version 2>/dev/null || true)"
fi

if command -v node >/dev/null 2>&1; then
  NODE_STATUS="installed"
  NODE_DETAIL="$(node --version 2>/dev/null || true)"
fi

if command -v docker >/dev/null 2>&1; then
  DOCKER_STATUS="installed"
  DOCKER_DETAIL="$(docker --version 2>/dev/null || true)"
fi

if command -v mise >/dev/null 2>&1; then
  MISE_STATUS="installed"
  MISE_DETAIL="$(mise --version 2>/dev/null | head -n 1 || true)"
fi

if command -v uv >/dev/null 2>&1; then
  UV_STATUS="installed"
  UV_DETAIL="$(uv --version 2>/dev/null || true)"
fi

if command -v ollama >/dev/null 2>&1; then
  OLLAMA_STATUS="installed"
  OLLAMA_DETAIL="$(ollama --version 2>/dev/null | head -n 1 || true)"
fi

GIT_NAME="$(git config --global user.name || true)"
GIT_EMAIL="$(git config --global user.email || true)"

cat > "$REPORT_FILE" <<EOF
# AIMac Report

- Generated: $TIMESTAMP
- System: $OS_NAME $OS_VERSION
- Architecture: $ARCH

## Tool Status

| Tool | Status | Detail |
|---|---|---|
| Homebrew | $BREW_STATUS | $BREW_DETAIL |
| Git | $GIT_STATUS | $GIT_DETAIL |
| Python 3 | $PYTHON_STATUS | $PYTHON_DETAIL |
| Node.js | $NODE_STATUS | $NODE_DETAIL |
| Docker | $DOCKER_STATUS | $DOCKER_DETAIL |
| mise | $MISE_STATUS | $MISE_DETAIL |
| uv | $UV_STATUS | $UV_DETAIL |
| Ollama | $OLLAMA_STATUS | $OLLAMA_DETAIL |

## Developer Identity

- git user.name: ${GIT_NAME:-not set}
- git user.email: ${GIT_EMAIL:-not set}

## Notes

- This is a snapshot report of the current machine state.
- Future versions should include plan/apply/verify artifacts and readiness scoring.
EOF

echo "AIMac Report"
echo "============"
echo
echo "Saved: $REPORT_FILE"
echo

cat "$REPORT_FILE"
