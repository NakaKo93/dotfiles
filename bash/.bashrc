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

# ---------- fzf ----------
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_ALT_C_COMMAND='rg --files --hidden --glob "!.git" -g "*/"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

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

# ---------- Functions ----------

# checkout git branch (including remote branches)
# https://github.com/junegunn/fzf/wiki/Examples#git
gcof() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# Interactive cd
# https://github.com/junegunn/fzf/wiki/Examples#interactive-cd
cdfd() {
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi
    while true; do
        local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
        local dir="$(printf '%s\n' "${lsd[@]}" |
            fzf --reverse --preview '
                __cd_nxt="$(echo {})";
                __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                echo $__cd_path;
                echo;
                ls -p --color=always "${__cd_path}";
        ')"
        [[ ${#dir} != 0 ]] || return 0
        builtin cd "$dir" &> /dev/null
    done
}

# cd into the selected directory
# https://github.com/junegunn/fzf/wiki/Examples#changing-directory
cdf() {
  DIR=`find * -maxdepth 0 -type d -print 2> /dev/null | fzf-tmux` \
    && cd "$DIR"
}

# Jump by z score (highest first)
# https://github.com/junegunn/fzf/wiki/Examples#z
cdz() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}
