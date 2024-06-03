# Alacritty Installation and Config

## Installation
```bash
sudo apt update && sudo apt upgrade
sudo add-apt-repository ppa:aslatter/ppa -y
sudo apt install alacritty
```

## Make Alacritty Default teriminal
```bash
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50

sudo update-alternatives --config x-terminal-emulator
```

## Install Nerd-Fonts
1. Run the following for installing a Nerd-Fonts. Example for installing FiraCode Font
```bash
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.local/share/fonts
fc-cache -fv
rm JetBrainsMono.zip
```

2. Update Alacritty configuration file `~/.config/alacritty/alacritty.yaml` to use new font:
```
font:
  normal:
    family: "FiraCode Nerd Font Mono"
  bold:
    family: "FiraCode Nerd Font Mono"
  italic:
    family: "FiraCode Nerd Font Mono"
  size: 12
```


## For changing configurations
```bash
mkcd $HOME/.config/alacritty
wget https://github.com/alacritty/alacritty/releases/download/v0.12.0/alacritty.yml
```
To make background opaque set 
```
window:
  opacity: 0.9
```