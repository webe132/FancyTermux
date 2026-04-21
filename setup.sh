#!/bin/bash

# System update and core dependencies
pkg update && pkg upgrade -y
pkg install git zsh curl fastfetch -y

# Termux interface configuration
mkdir -p ~/.termux
cat <<EOT > ~/.termux/termux.properties
extra-keys-text-scale = 0.6
extra-keys = [['ESC', 'TAB', 'CTRL', 'ALT', 'UP', 'LEFT', 'DOWN', 'RIGHT']]
font-size = 10
EOT

# Install JetBrains Mono Nerd Font
curl -fLo ~/.termux/font.ttf https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf --silent

# Apply Tokyo Night color scheme
cat <<EOT > ~/.termux/colors.properties
background: #1a1b26
foreground: #a9b1d6
cursor: #c0caf5
color0: #15161e
color1: #f7768e
color2: #9ece6a
color3: #e0af68
color4: #7aa2f7
color5: #bb9af7
color6: #7dcfff
color7: #a9b1d6
color8: #414868
color9: #f7768e
color10: #9ece6a
color11: #e0af68
color12: #7aa2f7
color13: #bb9af7
color14: #7dcfff
color15: #c0caf5
EOT

# Deploy Oh My Zsh
touch ~/.hushlogin
rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Configure .zshrc
cat <<EOT > ~/.zshrc
fastfetch
PROMPT='%F{cyan}%~ %F{green}%B>>>%b %f'
export ZSH="\$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
source \$ZSH/oh-my-zsh.sh
EOT

# Finalize environment
termux-reload-settings
chsh -s zsh
clear
fastfetch
exec zsh -l
