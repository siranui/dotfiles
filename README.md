# Dotfiles

このリポジトリは [chezmoi](https://www.chezmoi.io/) を使用してdotfilesを管理しています。

## Quick Start

### 新しいマシンへのインストール (Installation)

新しいマシンでdotfilesをセットアップするには、以下のワンライナーを実行してください。これにより `chezmoi` がインストールされ、リポジトリが初期化され、設定が適用されます。

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply siranui
```

### 変更の適用 (Update)

リポジトリの最新の状態をローカルに適用するには、以下のコマンドを実行します：

```sh
chezmoi update
```

これは `git pull` と `chezmoi apply` を実行するのと同等です。

### 基本的な使い方

- **設定ファイルの編集:**
  ```sh
  chezmoi edit ~/.zshrc
  ```

- **変更の確認:**
  ```sh
  chezmoi diff
  ```

- **変更の適用:**
  ```sh
  chezmoi apply
  ```

詳細な使用方法については [chezmoi Quick Start](https://www.chezmoi.io/quick-start/) を参照してください。
