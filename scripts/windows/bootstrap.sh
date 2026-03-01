#!/usr/bin/env bash
set -euo pipefail

# Install Scoop if not installed
if ! command -v scoop >/dev/null 2>&1; then
  powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -Command "irm get.scoop.sh | iex"
fi

# Add buckets
powershell.exe -NoProfile -Command "scoop bucket add extras; scoop bucket add versions"

# Install development tools via Scoop
PACKAGES=(
  ripgrep   # fast search (rg)
  fzf       # fuzzy finder
  vscode    # editor
  nodejs    # required for npm
  gh        # gh
  jq        # JSON processor (parse JSON in shell)
)

for pkg in "${PACKAGES[@]}"; do
  powershell.exe -NoProfile -Command "scoop install $pkg"
done

# Run fzf installer (safe to re-run)
"$HOME/.fzf/install" --key-bindings --completion --no-update-rc

# z
if [ ! -d "$HOME/z" ]; then
  git clone --depth 1 https://github.com/rupa/z.git "$HOME/z"
fi

# Install OpenAI Codex CLI via npm
if ! command -v codex >/dev/null 2>&1; then
  npm install -g @openai/codex
fi

echo "Bootstrap completed."
