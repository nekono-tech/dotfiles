#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

# mise が無ければ入れる（~/.local/bin に入る）
if ! command -v mise >/dev/null 2>&1; then
  curl -fsSL https://mise.run | sh
fi
export PATH="$HOME/.local/bin:$PATH"

# このリポジトリの mise.toml を信頼してから bootstrap
mise trust ./mise.toml

# --yes             : 確認プロンプトを出さない（無人実行のため）
# --force-dotfiles  : イメージ既存の ~/.zshrc などを symlink で置き換える
mise bootstrap --yes --force-dotfiles

# ログインシェルを zsh に変更
# chsh を本人で実行するとパスワードを聞かれるので、sudo 経由で root から変える
# （Codespaces はパスワード無し sudo、ローカル では sudo のパスワードを聞かれる）
ZSH_PATH="$(command -v zsh)"
CURRENT_SHELL="$(getent passwd "$(id -un)" | cut -d: -f7)"
if [ "$CURRENT_SHELL" != "$ZSH_PATH" ]; then
  sudo chsh -s "$ZSH_PATH" "$(id -un)"
fi
