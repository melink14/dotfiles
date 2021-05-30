# Requirements
- `apt install rcm` [for dotfile management](https://github.com/thoughtbot/rcm)
- `sudo apt install fzf` with plugin installed from [here](https://github.com/4z3/fzf-plugins)
- `sh -c "$(curl -fsSL https://starship.rs/install.sh)"` Install [starship](https://starship.rs/guide/#%F0%9F%9A%80-installation)
  - `eval "$(starship init bash)"` Add to near where local bashrc overrides are read. (Probably should add this to the repo directly)
- `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm` [tmux plugin manager](https://github.com/tmux-plugins/tpm)
  - Install plugins with `<prefix>-I`
