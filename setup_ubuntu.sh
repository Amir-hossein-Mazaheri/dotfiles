## It's a good to set SHECAN DNS before running ##

######## For terminal font you can download Cascadia  ########
# https://github.com/microsoft/cascadia-code/releases

# Update The APT Packages List
sudo apt update -y

# Preparation
sudo apt install neovim curl git gh zsh tmux build-essential neofetch htop -y

# Clone Config Files
git clone https://github.com/Amir-hossein-Mazaheri/nvim-config.git "$HOME"/.config/nvim
git clone https://github.com/Amir-hossein-Mazaheri/dotfiles.git "$HOME"/.config/dotfiles

# Install Packer for Neovim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Install Go
curl -JLO https://go.dev/dl/go1.23.4.linux-arm64.tar.gz
sudo rm -rf /usr/local/go
tar -xzf go1.23.4.linux-arm64.tar.gz
sudo cp -R go/ /usr/local/

# Install Kitty Terminal
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
mkdir "$HOME"/.local/bin
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
echo 'kitty.desktop' > ~/.config/xdg-terminals.list

# Install Oh-My-Zsh 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install P10K Theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-"$HOME"/.oh-my-zsh/custom}"/themes/powerlevel10k

# Installing NodeJS
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v1.39.3/install.sh | zsh
source "$HOME"/.zshrc
nvm install v22.12.0

# Installs Required Node Packages
npm i -g prettier eslint yarn pnpm

# Just Create a Directory!
mkdir "$HOME"/programming

# Remove Dotfiles Before Symlinking
sudo rm -rf ~/.icons ~/.themes ~/.kitty.conf ~/.zshrc ~/.tmux.conf ~/p10k-zsh ~/.wallpapers

# Link Icons, Themes, and Wallpapers
ln -s "$HOME"/.config/dotfiles/.icons "$HOME"/.icons
ln -s "$HOME"/.config/dotfiles/.themes "$HOME"/.themes
ln -s "$HOME"/.config/dotfiles/.wallpapers "$HOME"/.wallpapers

# Link ZSH and P10K
ln -s "$HOME"/.config/dotfiles/.zshrc "$HOME"/.zshrc
ln -s "$HOME"/.config/dotfiles/.p10k.zsh "$HOME"/.p10k.zsh

# Link Kitty
ln -s "$HOME"/.config/dotfiles/kitty.conf "$HOME"/.config/kitty/kitty.conf

# Link Tmux
ln -s "$HOME"/.config/dotfiles/.tmux.conf "$HOME"/.tmux.conf


# Install PyEnv
sudo apt install curl git-core gcc make zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libssl-dev -y
curl https://pyenv.run | bash
source "$HOME"/.zshrc

# Install Python 3.8 via PyEnv
pyenv install 3.8.12
pyenv global 3.8.12
source "$HOME"/.zshrc


# Install V2rayA
wget -qO - https://apt.v2raya.org/key/public-key.asc | sudo tee /etc/apt/keyrings/v2raya.asc
echo "deb [signed-by=/etc/apt/keyrings/v2raya.asc] https://apt.v2raya.org/ v2raya main" | sudo tee /etc/apt/sources.list.d/v2raya.list
sudo apt update
sudo apt install v2raya v2ray -y
sudo systemctl start v2raya.service
sudo systemctl enable v2raya.service

# Install Gnome-Tweaks and Gnome-Extension-Manager
sudo apt install gnome-tweaks gnome-shell-extension-manager -y

# Installs Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install Docker
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Installation of ZSH Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git "$ZSH_CUSTOM"/plugins/you-should-use

sudo apt install bat -y
git clone https://github.com/fdellwing/zsh-bat.git "$ZSH_CUSTOM"/plugins/zsh-bat

# Install Brave
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser -y

# Install Pi Apps
# Install Pi Imager, LibreOffice MS Theme, Wine, More RAM, Timeshift, and OBS Studio
wget -qO- https://raw.githubusercontent.com/Botspot/pi-apps/master/install | bash

# Install Flatpak and Flathub
sudo apt install flatpak -y
sudo apt install gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install Perspolis DM
sudo add-apt-repository ppa:persepolis/ppa
sudo apt update
sudo apt install persepolis -y

