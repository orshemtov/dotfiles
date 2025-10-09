#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

# List top-level non-hidden folders (your stow packages)
packages=($(find . -maxdepth 1 -type d ! -name '.*' -exec basename {} \;))

echo "==> Found packages: ${packages[*]}"
echo "==> Dry run:"
stow -nRv --adopt -t "$HOME" "${packages[@]}"
echo

read -rp "Apply changes? [y/N] " ans
if [[ "${ans:-N}" =~ ^[Yy]$ ]]; then
  stow -Rv --adopt -t "$HOME" "${packages[@]}"
  echo "✅ All packages stowed."
else
  echo "❌ Aborted."
fi
