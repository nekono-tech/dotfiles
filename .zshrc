##############################################################
# Oh My Zsh 設定
##############################################################

# Oh My Zsh がインストールされているディレクトリの指定
export ZSH="$HOME/.oh-my-zsh"

# ターミナルの見た目（テーマ）の設定
# robbyrussell: デフォルトのシンプルで使いやすいテーマ
ZSH_THEME="robbyrussell"

# 拡張機能（プラグイン）の有効化
# git: gitコマンドの補完やエイリアス
# zsh-autosuggestions: 入力履歴から補完を表示
# zsh-syntax-highlighting: コマンドが正しいかどうか色で判別
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Oh My Zsh の本体を起動（これより上に設定を書く必要がある）
source $ZSH/oh-my-zsh.sh


##############################################################
# 外部ツールの初期化設定
##############################################################

# Homebrew の環境設定
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# nodenv の初期化
eval "$(nodenv init -)"
