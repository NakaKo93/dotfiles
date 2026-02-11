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
