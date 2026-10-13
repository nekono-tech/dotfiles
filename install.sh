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

# --yes             : 確認プロンプトを出さない
# --force-dotfiles  : イメージ既存の ~/.zshrc などを symlink で置き換える
mise bootstrap --yes --force-dotfiles
