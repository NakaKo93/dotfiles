# パスの設定
export PATH=$PATH:$HOME

# .bashrcの読み込み
[[ -f ~/.bashrc ]] && source ~/.bashrc

# コマンド履歴の設定
export HISTFILE=~/.bash_history
export HISTSIZE=1000
export HISTFILESIZE=1000
export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '
export HISTIGNORE='history:clear'

# コマンド履歴の保存
export PROMPT_COMMAND='history -a'

# alias（短縮コマンド）を設定する
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
alias ll='ls -lh --color=auto'
alias l='ls -CF'
alias gd='git diff'
alias gst='git stash'
alias ga='git add'
alias gp='git push'
alias gcm='git commit -m'
alias gcp='git cherry-pick'

# Judge0の起動用エイリアス
alias 'dcuj'='docker compose up -d redis db && \
    sleep 3 && \
    docker compose up -d'

# ディレクトリを作成してその場で移動
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# vimをデフォルトエディタに設定する
export EDITOR=vim

# ターミナルの動作を高速化する
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'set bell-style none'
