#!/usr/bin/env bash

echo "🔍 Detecting environment..."

# Homebrew
if command -v brew >/dev/null 2>&1; then
  echo "✔ Homebrew: installed"
else
  echo "✖ Homebrew: missing"
fi

# Git
if command -v git >/dev/null 2>&1; then
  echo "✔ Git: installed"
else
  echo "✖ Git: missing"
fi

# Node
if command -v node >/dev/null 2>&1; then
  echo "✔ Node: installed"
else
  echo "✖ Node: missing"
fi

# Python
if command -v python3 >/dev/null 2>&1; then
  echo "✔ Python: installed"
else
  echo "✖ Python: missing"
fi

# Docker
if command -v docker >/dev/null 2>&1; then
  echo "✔ Docker: installed"
else
  echo "✖ Docker: missing"
fi
