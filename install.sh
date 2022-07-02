#!/bin/bash

sudo apt update
sudo apt install rcm
sudo apt install fzf
sh -c "$(curl -fsSL https://starship.rs/install.sh)"

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

rcup

echo "Installation complete. Install tmux plugins with <prefix>-I"