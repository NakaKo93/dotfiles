#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/dotfiles"

# Install a single file from the dotfiles repository to the local system.
# $1: source file in the dotfiles repository
# $2: destination path on the local system
install_file() {
    local dotfile="$1"
    local localfile="$2"

    # back it up before overwriting if the destination exists.
    if [ -e "$localfile" ]; then
        mv "$localfile" "$localfile.bak"
    fi

    cp -f "$dotfile" "$localfile"
}

# bash
install_file "$DOTFILES/.bash_profile" "$HOME/.bash_profile"
install_file "$DOTFILES/.bashrc"       "$HOME/.bashrc"
