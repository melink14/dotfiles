#!/bin/bash

sudo apt update
DEBIAN_FRONTEND=noninteractive \
  sudo apt \
  -y install rcm fzf
sh -c "$(curl -fsSL https://starship.rs/install.sh)"

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

RCRC=./rcrc rcup -d .

echo "Installation complete. Install tmux plugins with <prefix>-I"