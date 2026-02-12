#!/bin/bash
# NvChad starter の上にカスタム設定をオーバーレイする
# chezmoi apply 後に毎回実行される

set -eu

NVIM_CUSTOM="$HOME/.config/nvim_custom"
NVIM_CONFIG="$HOME/.config/nvim"

if [ -d "$NVIM_CUSTOM" ] && [ -d "$NVIM_CONFIG" ]; then
    echo "Applying custom NvChad configurations..."
    # カスタム設定を上書きコピー（ディレクトリ構造を保持）
    cp -Rf "$NVIM_CUSTOM"/* "$NVIM_CONFIG"/
    echo "Custom NvChad configurations applied successfully."
else
    echo "Warning: $NVIM_CUSTOM or $NVIM_CONFIG does not exist. Skipping NvChad custom config overlay."
fi
