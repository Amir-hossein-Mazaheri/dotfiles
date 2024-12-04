################################################# ATTENTIONS!!!!!!!!!!!!! ########################################################
# DON'T RUN WITH SUDO
##################################################
## It's a good to set SHECAN DNS before running ##

# Update The APT Packages List
sudo apt update -y

# Preparation
sudo apt install neovim curl git gh zsh tmux build-essential neofetch -y

# Clone Config Files
git clone https://github.com/Amir-hossein-Mazaheri/nvim-config.git /home/$(whoami)/.config/nvim
git clone https://github.com/Amir-hossein-Mazaheri/dotfiles.git /home/$(whoami)/.config/dotfiles

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
mkdir /home/$(whoami)/.local/bin
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
echo 'kitty.desktop' > ~/.config/xdg-terminals.list

# Install Oh-My-Zsh 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install P10K Theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Installing NodeJS
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v1.39.3/install.sh | zsh
source $HOME/.zshrc
nvm install v22.12.0

# Installs Required Node Packages
npm i -g prettier eslint yarn pnpm

# Just Create a Directory!
mkdir /home/$(whoami)/programming

# Remove Dotfiles Before Symlinking
sudo rm -rf ~/.icons ~/.themes ~/.kitty.conf ~/.zshrc ~/.tmux.conf ~/p10k-zsh ~/.wallpapers

# Link Icons, Themes, and Wallpapers
ln -s /home/$(whoami)/.config/dotfiles/.icons /home/$(whoami)/.icons
ln -s /home/$(whoami)/.config/dotfiles/.themes /home/$(whoami)/.themes
ln -s /home/$(whoami)/.config/dotfiles/.wallpapers /home/$(whoami)/.wallpapers

# Link ZSH and P10K
ln -s /home/$(whoami)/.config/dotfiles/.zshrc /home/$(whoami)/.zshrc
ln -s /home/$(whoami)/.config/dotfiles/.p10k.zsh /home/$(whoami)/.p10k.zsh

# Link Kitty
ln -s /home/$(whoami)/.config/dotfiles/.kitty.conf /home/$(whoami)/.kitty.conf


# Install PyEnv
sudo apt install curl git-core gcc make zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libssl-dev -y
curl https://pyenv.run | bash
source $HOME/.zshrc

# Install Python 3.8 via PyEnv
pyenv install 3.8.12
pyenv global 3.8.12
source $HOME/.zshrc


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
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use

sudo apt install bat -y
git clone https://github.com/fdellwing/zsh-bat.git $ZSH_CUSTOM/plugins/zsh-bat



