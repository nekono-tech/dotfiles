#!/usr/bin/env bash
# dotfiles のシンボリックリンクを張る
#
#   ./install.sh        リンクを作成（既存ファイルは .bak を付けて退避）
#   ./install.sh --dry  実際には変更せず、何をするかだけ表示
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=false
[[ "${1:-}" == "--dry" ]] && DRY_RUN=true

# 管理対象: "リポジトリ内のパス:リンク先($HOME からの相対パス)"
LINKS=(
  ".zshrc:.zshrc"
  ".config/starship.toml:.config/starship.toml"
)

link() {
  local src="$DOTFILES_DIR/$1" dest="$HOME/$2"

  if [[ ! -e "$src" ]]; then
    echo "skip   $2 (リポジトリ側に $1 がない)"
    return
  fi

  if [[ -L "$dest" && "$(readlink -f "$dest")" == "$(readlink -f "$src")" ]]; then
    echo "ok     $2"
    return
  fi

  if $DRY_RUN; then
    echo "would  $2 -> $src"
    return
  fi

  mkdir -p "$(dirname "$dest")"

  # 既存の実ファイル・ディレクトリは退避してから張り替える
  if [[ -e "$dest" && ! -L "$dest" ]]; then
    mv "$dest" "$dest.bak.$(date +%Y%m%d%H%M%S)"
    echo "backup $2 -> $2.bak.*"
  fi

  ln -sfn "$src" "$dest"
  echo "link   $2 -> $src"
}

for entry in "${LINKS[@]}"; do
  link "${entry%%:*}" "${entry#*:}"
done
