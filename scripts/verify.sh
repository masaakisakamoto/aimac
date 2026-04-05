#!/usr/bin/env bash

set -u

PROFILE="beginner"

for arg in "$@"; do
  case "$arg" in
    --profile=*)
      PROFILE="${arg#*=}"
      ;;
  esac
done

echo "AIMac Verify"
echo "============"
echo
echo "Profile: $PROFILE"
echo

pass_count=0
warn_count=0
fail_count=0

pass() {
  echo "✔ PASS: $1"
  pass_count=$((pass_count + 1))
}

warn() {
  echo "⚠ WARN: $1"
  warn_count=$((warn_count + 1))
}

fail() {
  echo "✖ FAIL: $1"
  fail_count=$((fail_count + 1))
}

print_section() {
  echo
  echo "[$1]"
}

# --------------------------------------------------
# Core usability checks
# --------------------------------------------------
print_section "Core Usability"

if command -v git >/dev/null 2>&1; then
  pass "Git is available"
else
  fail "Git is missing"
fi

if command -v python3 >/dev/null 2>&1; then
  if python3 -c "print('ok')" >/dev/null 2>&1; then
    pass "Python 3 is runnable"
  else
    fail "Python 3 exists but is not runnable"
  fi
else
  fail "Python 3 is missing"
fi

if command -v node >/dev/null 2>&1; then
  if node -e "console.log('ok')" >/dev/null 2>&1; then
    pass "Node.js is runnable"
  else
    fail "Node.js exists but is not runnable"
  fi
else
  fail "Node.js is missing"
fi

if command -v brew >/dev/null 2>&1; then
  pass "Homebrew is available"
else
  fail "Homebrew is missing"
fi

# --------------------------------------------------
# Runtime manager checks
# --------------------------------------------------
print_section "Runtime Management"

if command -v mise >/dev/null 2>&1; then
  pass "mise is available"
else
  warn "mise is missing"
fi

if command -v uv >/dev/null 2>&1; then
  pass "uv is available"
else
  warn "uv is missing"
fi

# --------------------------------------------------
# Editor / tooling checks
# --------------------------------------------------
print_section "Developer Tooling"

if command -v code >/dev/null 2>&1; then
  pass "VS Code CLI is available"
else
  warn "VS Code CLI is not available"
fi

if command -v docker >/dev/null 2>&1; then
  pass "Docker CLI is available"
else
  warn "Docker CLI is missing"
fi

# --------------------------------------------------
# Optional local AI checks
# --------------------------------------------------
print_section "Local AI"

if command -v ollama >/dev/null 2>&1; then
  if ollama list >/dev/null 2>&1; then
    pass "Ollama is available and responding"
  else
    warn "Ollama is installed but not responding"
  fi
else
  warn "Ollama is not installed"
fi

# --------------------------------------------------
# Git identity checks
# --------------------------------------------------
print_section "Developer Identity"

GIT_NAME="$(git config --global user.name || true)"
GIT_EMAIL="$(git config --global user.email || true)"

if [[ -n "$GIT_NAME" ]]; then
  pass "git user.name is set"
else
  warn "git user.name is not set"
fi

if [[ -n "$GIT_EMAIL" ]]; then
  pass "git user.email is set"
else
  warn "git user.email is not set"
fi

# --------------------------------------------------
# Profile-specific checks
# --------------------------------------------------
print_section "Profile Checks"

case "$PROFILE" in
  beginner)
    if command -v python3 >/dev/null 2>&1 && command -v node >/dev/null 2>&1; then
      pass "Beginner profile essentials are present"
    else
      fail "Beginner profile essentials are incomplete"
    fi
    ;;
  builder)
    if command -v gh >/dev/null 2>&1; then
      pass "GitHub CLI is available"
    else
      warn "GitHub CLI is missing for builder profile"
    fi
    ;;
  local-ai)
    if command -v ollama >/dev/null 2>&1; then
      pass "Ollama is installed for local-ai profile"
    else
      fail "Ollama is required for local-ai profile"
    fi
    ;;
  minimal)
    pass "Minimal profile selected"
    ;;
  *)
    warn "Unknown profile: $PROFILE"
    ;;
esac

# --------------------------------------------------
# Summary
# --------------------------------------------------
print_section "Summary"

echo "Pass: $pass_count"
echo "Warn: $warn_count"
echo "Fail: $fail_count"

if (( fail_count > 0 )); then
  echo
  echo "Verification result: FAIL"
  exit 1
elif (( warn_count > 0 )); then
  echo
  echo "Verification result: PASS WITH WARNINGS"
  exit 0
else
  echo
  echo "Verification result: PASS"
  exit 0
fi
