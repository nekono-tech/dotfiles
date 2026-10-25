##############################################################
# Homebrew
##############################################################

# PATH と補完パスを通すので、他の設定より先に実行する
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# brew で入れたコマンドの補完（task, uv, nodenv など）。
# compinit より前に fpath へ入れる必要がある
fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)

##############################################################
# 補完
##############################################################

autoload -Uz compinit
# 補完キャッシュはホーム直下を汚さないよう ~/.cache/zsh に置く
ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION"
[[ -d ${ZSH_COMPDUMP:h} ]] || mkdir -p "${ZSH_COMPDUMP:h}"
compinit -d "$ZSH_COMPDUMP"

# 補完候補を矢印キーで選べるようにする
zstyle ':completion:*' menu select
# 大文字小文字を区別しない補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 単語の途中でも補完する / 補完したらカーソルを末尾へ送る
setopt complete_in_word
setopt always_to_end

##############################################################
# 履歴
##############################################################

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt share_history          # 複数のシェルで履歴を共有
setopt hist_ignore_all_dups   # 同じコマンドは古い方を削除
setopt hist_ignore_space      # 先頭スペース付きのコマンドは記録しない
setopt hist_reduce_blanks     # 余分な空白を詰めて記録
setopt extended_history       # 実行時刻も記録

##############################################################
# キーバインド
##############################################################

bindkey -e  # Emacs キーバインド

# 入力した文字列で前方一致検索しながら履歴を辿る（↑ / ↓）
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# Home / End（端末によって送る文字列が違うので主要な形を登録しておく）
bindkey '^[[H'  beginning-of-line
bindkey '^[OH'  beginning-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[F'  end-of-line
bindkey '^[OF'  end-of-line
bindkey '^[[4~' end-of-line

# Delete / Ctrl+Delete
bindkey '^[[3~'   delete-char
bindkey '^[[3;5~' kill-word

# Ctrl + ← → で単語単位に移動
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Ctrl+Backspace で直前の単語を削除
bindkey '^H' backward-kill-word

# Shift+Tab で補完候補を逆順に辿る
bindkey '^[[Z' reverse-menu-complete

##############################################################
# エイリアス / 色付け
##############################################################

# ls の色（実行可能ファイル・ディレクトリ・シンボリックリンクなどの色分け）。
# oh-my-zsh が設定していた分を明示的に書いている
eval "$(dircolors -b)"
alias ls='ls --color=auto'

alias ll='ls -lh'
alias la='ls -lAh'
alias l='ls -CF'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# 補完候補にも ls と同じ色を使う
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

##############################################################
# PATH / 環境変数
##############################################################

# ~/.local/bin（claude など）を PATH に追加
export PATH="$HOME/.local/bin:$PATH"

export PKG_CONFIG_PATH="/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/share/pkgconfig:${PKG_CONFIG_PATH:-}"

##############################################################
# zsh プラグイン（brew 管理）
##############################################################

# zsh-autosuggestions: 入力履歴から補完を表示
[[ -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] \
  && source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zsh-syntax-highlighting: コマンドが正しいかどうか色で判別
# 他のプラグインより後に読み込む必要がある
[[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] \
  && source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

##############################################################
# プロンプト
##############################################################

# starship の初期化（プロンプトを上書きするので最後に実行する）
eval "$(starship init zsh)"
