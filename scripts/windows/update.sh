#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/dotfiles"

# Update a single file from the local system to the dotfiles repository.
# $1: source file on the local system
# $2: destination path in the dotfiles repository
update_file() {
    local localfile="$1"
    local dotfile="$2"

    # Only copy if the local file exists
    if [ -f "$localfile" ]; then
        cp -f "$localfile" "$dotfile"
    fi
}

# bash
update_file "$HOME/.bash_profile" "$DOTFILES/bash/.bash_profile"
update_file "$HOME/.bashrc"       "$DOTFILES/bash/.bashrc"

# git ssh
update_file "$HOME/.ssh/config.example" "$DOTFILES/ssh/.ssh/config.example"

# zshrc
update_file "$HOME/.zshrc" "$DOTFILES/zsh/.zshrc"

# vscode
VSCODE_DIR="$HOME/AppData/Roaming/Code/User"

update_file "$VSCODE_DIR/settings.json"    "$DOTFILES/vscode/settings.json"
update_file "$VSCODE_DIR/keybindings.json" "$DOTFILES/vscode/keybindings.json"

if command -v code >/dev/null 2>&1; then
  code --list-extensions > "$DOTFILES/vscode/extensions.txt"
fi

echo "Update completed."
