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

echo "AIMac First Success"
echo "==================="
echo
echo "Profile: $PROFILE"
echo

mkdir -p artifacts
TIMESTAMP="$(date +"%Y%m%d-%H%M%S")"
OUTPUT_FILE="artifacts/first-success-${PROFILE}-${TIMESTAMP}.md"

pass() {
  echo "✔ $1"
}

fail() {
  echo "✖ $1"
}

write_output() {
  cat > "$OUTPUT_FILE" <<EOF
# AIMac First Success

- Generated: $TIMESTAMP
- Profile: $PROFILE

EOF
}

append_output() {
  if [ "$#" -eq 0 ]; then
    echo >> "$OUTPUT_FILE"
  else
    echo "$1" >> "$OUTPUT_FILE"
  fi
}

write_output

case "$PROFILE" in
  beginner)
    if ! command -v python3 >/dev/null 2>&1; then
      fail "Python 3 is required for beginner first success"
      exit 1
    fi

    RESULT="$(python3 - <<'PY'
print("Hello from AIMac.")
print("Your Mac is ready for a first AI-learning step.")
PY
)"
    echo "$RESULT"

    pass "Beginner first success completed"
    append_output "## Result"
    append_output
    append_output '```text'
    append_output "$RESULT"
    append_output '```'
    append_output
    append_output "- Status: success"
    ;;
  builder)
    if ! command -v gh >/dev/null 2>&1; then
      fail "GitHub CLI is required for builder first success"
      exit 1
    fi

    GH_VERSION="$(gh --version 2>/dev/null | head -n 1 || true)"
    PY_VERSION="$(python3 --version 2>/dev/null || true)"
    NODE_VERSION="$(node --version 2>/dev/null || true)"

    echo "GitHub CLI: $GH_VERSION"
    echo "Python: $PY_VERSION"
    echo "Node: $NODE_VERSION"

    pass "Builder first success completed"
    append_output "## Result"
    append_output
    append_output "- GitHub CLI: $GH_VERSION"
    append_output "- Python: $PY_VERSION"
    append_output "- Node: $NODE_VERSION"
    append_output
    append_output "- Status: success"
    ;;
  *)
    fail "Unknown profile: $PROFILE"
    exit 1
    ;;
esac

echo
echo "Saved: $OUTPUT_FILE"
