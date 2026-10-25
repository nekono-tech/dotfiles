# dotfiles

WSL2 (Ubuntu) + zsh + starship の環境設定。

## 管理しているもの

| リポジトリ内 | リンク先 | 内容 |
| --- | --- | --- |
| `.zshrc` | `~/.zshrc` | zsh の設定（履歴・補完・エイリアス・PATH） |
| `.config/starship.toml` | `~/.config/starship.toml` | プロンプト（starship）の設定 |

## セットアップ

```sh
git clone git@github.com:nekono-tech/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh          # --dry を付けると変更内容の確認のみ
```

`install.sh` は冪等で、既存の実ファイルがある場合は `*.bak.<日時>` に退避してからリンクを張る。

## 前提ツール

`.zshrc` が参照しているもの。入っていない環境では該当行を消すか、先にインストールする。

- [Homebrew](https://brew.sh/)（PATH と補完パスを通すため最初に実行）
- [starship](https://starship.rs/) … プロンプト
- `zsh-autosuggestions` / `zsh-syntax-highlighting` … brew 管理

  ```sh
  brew install starship zsh-autosuggestions zsh-syntax-highlighting
  ```

## メモ

- プロンプトは oh-my-zsh から starship に移行済み。`~/.oh-my-zsh` は不要。
- 言語ランタイムの管理ツールは現在入れていない（pyenv / nodenv / mise はすべて削除済み）。
  node や python が必要になったら [mise](https://mise.jdx.dev/) を入れ直し、
  `~/.config/mise/config.toml` をこのリポジトリの管理対象に戻す。
- 補完キャッシュは `~/.cache/zsh/zcompdump-<version>` に置いてホーム直下を汚さない。
- `zsh-syntax-highlighting` は他のプラグインより後に読み込む必要があるため、`.zshrc` の末尾付近で source している。
