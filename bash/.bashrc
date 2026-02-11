# ---------- History ----------
export HISTFILE="$HOME/.bash_history"
export HISTSIZE=1000
export HISTFILESIZE=1000
export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '
export HISTIGNORE='history:clear'
shopt -s histappend

# ---------- z ----------
export _Z_CMD="z"
[ -r "$HOME/z/z.sh" ] && source "$HOME/z/z.sh"

# ---------- Aliases ----------
alias dcu='docker compose up'
alias dcd='docker compose down'
alias dps='docker ps'
alias la='ls -la'
alias ll='ls -lh --color=auto'
alias l='ls -CF'
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
alias gd='git diff'
alias gst='git stash'
alias ga='git add'
alias gp='git push'
alias gcm='git commit -m'
alias gcp='git cherry-pick'

alias dcuj='docker compose up -d redis db && sleep 3 && docker compose up -d'

# ---------- Functions ----------
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# ---------- Prompt ----------
set_bash_prompt() {
  local branch="" env=""

  if git rev-parse --is-inside-work-tree &>/dev/null; then
    branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  fi

  env="$MSYSTEM"

  PS1=""
  PS1+="\[\e[92m\]\u@\h\[\e[0m\]"
  PS1+=" \[\e[95m\]$env\[\e[0m\]"
  PS1+=" \[\e[1;33m\]\w\[\e[0m\]"
  [ -n "$branch" ] && PS1+=" \[\e[96m\]($branch)\[\e[0m\]"
  PS1+="\n\$ "
}

PROMPT_COMMAND="history -a; set_bash_prompt; $PROMPT_COMMAND"

# ---------- Misc ----------
export EDITOR=vim

bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'set bell-style none'
