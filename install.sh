#!/bin/bash

# Install a nerd font needed by starship
echo "[-] Download fonts [-]"
echo "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip
unzip CascadiaCode.zip -d ~/.fonts
fc-cache -fv
echo "done!"

sudo apt update
DEBIAN_FRONTEND=noninteractive \
  sudo apt \
  -y install rcm fzf


curl -sS https://starship.rs/install.sh | sh -s -- --yes

git clone https://github.com/4z3/fzf-plugins ~/.fzf-plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

RCRC=./rcrc rcup -f -d .

echo "Installation complete. Install tmux plugins with <prefix>-I"