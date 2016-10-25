#!/bin/bash

TPM_DIR="$HOME/.tmux/plugins/tpm"

if [ ! -d ${TPM_DIR} ]; then
   echo "Download tpm..."
   git clone https://github.com/tmux-plugins/tpm "${TPM_DIR}"
fi
