#!/bin/bash

if [! -e '~/.vim/plugged/vim-plug']; then
   echo 'install vim-plug...'
   mkdir -p ~/.vim/plugged/vim-plug
   git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload
fi

# vim -c " q! " #-e -s -V1
vim -c "try | PlugInstall | q! | finally | q! | endtry" #-e -s -V1


