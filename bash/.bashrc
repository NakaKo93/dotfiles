# プロンプト表示を変更
set_bash_prompt() {
  local branch="" env=""

  # Git リポジトリ内ならブランチ名を取得
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  fi

  # Git Bash (MSYS2) の環境名（MINGW64 等）を取得
  if [ -n "$MSYSTEM" ]; then
    env="$MSYSTEM"
  fi

  # PS1 の組み立て
  PS1=""
  # ユーザ名@ホスト名 を黄緑に
  PS1+="\[\e[92m\]\u@\h\[\e[0m\]"
  # 環境名 (MINGW64) をピンクに
  PS1+=" \[\e[95m\]$env\[\e[0m\]"
  # カレントディレクトリをオレンジに
  PS1+=" \[\e[1;33m\]\w\[\e[0m\]"
  # Git ブランチがあれば水色で (branch)
  if [ -n "$branch" ]; then
    PS1+=" \[\e[96m\]($branch)\[\e[0m\]"
  fi
  # 改行して、プロンプト記号
  PS1+="\n\$ "
}
# プロンプト表示の直前に set_bash_prompt を呼ぶ
export PROMPT_COMMAND=set_bash_prompt

# z コマンドの設定
# z コマンドのスクリプト読み込み
[[ -r "$HOME/z/z.sh" ]] && source "$HOME/z/z.sh"
# コマンド名と履歴保存先を設定
export _Z_CMD="z"
export _Z_DATA="$HOME/.z"
# cd を拡張して z に履歴を残す
function cd() {
  builtin cd "$@" && _z --add "$(pwd)"
}
export PATH="/c/Ruby34-x64/bin:$PATH"
