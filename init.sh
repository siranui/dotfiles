#!/bin/bash

set -e
DOT_DIR="$HOME/dotfiles"
DOT_TARBALL="https://github.com/siranui/dotfiles/tarball/master"
REMOTE_URL="https://github.com/siranui/dotfiles.git"


has() {
   type "$1" > /dev/null 2>&1
}

usage() {
   name=`basename $0`
   cat <<EOF
Usage:
   $name [arguments] [command]
Commands:
   deploy
   initialize
Arguments:
   -f $(tput setaf 1)** warning **$(tput sgr0) Overwrite dotfiles.
   -h Print help (this message)
EOF
   exit 1
}


# オプション -fは上書き、-hはヘルプ表示
while getopts :f:h opt; do
   case ${opt} in
      f)
         OVERWRITE=true
         ;;
      h)
         usage
         ;;
   esac
done
shift $((OPTIND - 1))

# Dotfilesがない、あるいは上書きオプションがあればダウンロード
if [ -n "${OVERWRITE}" -o ! -d ${DOT_DIRECTORY} ]; then
   echo "Downloading dotfiles..."
   rm -rf ${DOT_DIRECTORY}
   mkdir ${DOT_DIRECTORY}

   if has "git"; then
      git clone --recursive "${REMOTE_URL}" "${DOT_DIR}"
   else
      curl -fsSLo ${HOME}/dotfiles.tar.gz ${DOT_TARBALL}
      tar -zxf ${HOME}/dotfiles.tar.gz --strip-components 1 -C ${DOT_DIRECTORY}
      rm -f ${HOME}/dotfiles.tar.gz
   fi

   echo $(tput setaf 2)Download dotfiles complete!. ✔︎$(tput sgr0)
fi

link_files() {
   # ... Deploy処理
   for f in .??*
   do
      [ "$f" = ".git" ] && continue

      ln -sf ~/dotfiles/$f ~/$f
      echo "$f"
   done
}

initialize() {
   # ... Initialize処理
   TPM_DIR="$HOME/.tmux/plugins/tpm"
   ZPLUG_DIR="$HOME/.zplug"
   VIMPLUG_DIR="$HOME/.vim/plugged/vim-plug"


   if has "git"; then
      :
   else
      echo "Install git..."
      has apt && apt install git -y
   fi

   # tpm
   if [ ! -d ${TPM_DIR} ]; then
      echo "Download tpm..."
      has git && git clone https://github.com/tmux-plugins/tpm "${TPM_DIR}"
   fi

   # zplug
   if [ ! -d ${ZPLUG_DIR} ]; then
      echo "Download zplug..."
      has curl && curl -sL zplug.sh/installer | zsh
   fi

   # vim-plug
   if [ ! -e ${VIMPLUG_DIR} ]; then
      echo 'install vim-plug...'
      mkdir -p ~/.vim/plugged/vim-plug
      has git && git clone https://github.com/junegunn/vim-plug.git "${VIMPLUG_DIR}"/autoload
      # Install plugins
      vim -c "try | PlugInstall | q! | finally | q! | endtry"
   else
      :
   fi

   # シェルをzshにする
   [ ${SHELL} != "/bin/zsh"  ] && chsh -s /bin/zsh
   echo "$(tput setaf 2)Initialize complete!. ✔︎ $(tput sgr0)"
}

# 引数によって場合分け
command=$1
[ $# -gt 0 ] && shift

# 引数がなければヘルプ
case $command in
   deploy)
      link_files
      ;;
   init*)
      initialize
      ;;
   *)
      usage
      ;;
esac

exit 0
