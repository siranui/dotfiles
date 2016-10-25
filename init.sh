#!/bin/bash

set -e
TPM_DIR="$HOME/.tmux/plugins/tpm"

has() {
   type "$1" > /dev/null 2>&1
}

# git の存在確認
if has "git"; then
   :
else
   echo "Install git..."
   apt install git -y
fi

# deploy
for f in .??*
do
    [ "$f" = ".git" ] && continue

    ln -sf ~/dotfiles/$f ~/$f
    echo "$f"
done

# tpm
if [ ! -d ${TPM_DIR} ]; then
   echo "Download tpm..."
   git clone https://github.com/tmux-plugins/tpm "${TPM_DIR}"
fi

# vim-plug
if [ ! -e ~/.vim/plugged/vim-plug ]; then
   echo 'install vim-plug...'
   mkdir -p ~/.vim/plugged/vim-plug
   git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload
   # Install plugins
   vim -c "try | PlugInstall | q! | finally | q! | endtry"
else
   :
fi

