# ----- Basics -----
export EDITOR=vim
export PATH="$PATH:$HOME"

# ----- History (zsh) -----
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# ----- Aliases -----
alias dcu='docker compose up'
alias dcd='docker compose down'
alias dps='docker ps'

alias la='ls -la'
alias gsu='git status -u'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout main'
alias gc='git commit'
alias gpom='git pull origin main'
alias gpo='git pull origin'
alias gb='git branch'
alias gm='git merge'
alias gmm='git merge main'
alias ll='ls -lh'
alias l='ls -CF'
alias gd='git diff'
alias gst='git stash'
alias ga='git add'
alias gp='git push'
alias gcm='git commit -m'
alias gcp='git cherry-pick'

alias dcuj='docker compose up -d redis db && sleep 3 && docker compose up -d'

mkcd() { mkdir -p "$1" && cd "$1" }

# ----- z (directory jump) -----
export _Z_CMD="z"
[ -r "$HOME/z/z.sh" ] && source "$HOME/z/z.sh"

# ----- Completion -----
autoload -Uz compinit
compinit

# ----- Prompt (zsh) -----
autoload -Uz colors && colors

setopt PROMPT_SUBST

git_branch() {
    command git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return
    command git rev-parse --abbrev-ref HEAD 2>/dev/null
}

# Similar look to your bash prompt (user@host env cwd (branch))
PROMPT='%F{green}%n@%m%f %F{magenta}${MSYSTEM}%f %F{yellow}%~%f$(b=$(git_branch); [[ -n "$b" ]] && print " %_
