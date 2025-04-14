#!/bin/bash

# This script installs Git hooks from scripts/githooks to .git/hooks
echo "Installing Git hooks..."

HOOKS_DIR="scripts/githooks"
GIT_HOOKS_DIR=".git/hooks"

# Ensure .git/hooks exists
if [ ! -d "$GIT_HOOKS_DIR" ]; then
  echo "Error: .git/hooks directory not found. Are you inside a Git repository?"
  exit 1
fi

# Copy hooks
for hook in "$HOOKS_DIR"/*; do
  hook_name=$(basename "$hook")
  echo "Installing $hook_name..."
  cp "$hook" "$GIT_HOOKS_DIR/$hook_name"
  chmod +x "$GIT_HOOKS_DIR/$hook_name"
done

echo "All Git hooks installed successfully."