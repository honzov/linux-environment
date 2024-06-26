#!/bin/bash
set -e

if [ "$1" = "--install" ]; then
  # identify package manager, upgrade and install OS specific packages
  if hash pacman 2>/dev/null; then
      # Arch linux
      pacman -Syu --noconfirm --needed sudo || true
      sudo pacman -Syu --noconfirm
      sudo pacman -S --noconfirm --needed base-devel zsh-completions git
      # Yay
      if ! hash yay 2>/dev/null; then ./bin/aur-install yay-bin --noconfirm --needed; fi
      # Direnv
      if ! hash direnv 2>/dev/null; then ./bin/aur-install direnv --noconfirm --needed; fi
      pacman_bin="pacman -S --noconfirm --needed"
      pynvim_pkg="python-pynvim"
  elif hash dnf 2>/dev/null; then
      # Fedora
      dnf -y install sudo || true
      sudo dnf -y upgrade
      sudo dnf -y group install 'Development Tools'
      sudo dnf -y install util-linux-user direnv
      pacman_bin="dnf -y install"
      pynvim_pkg="python3-neovim"
  elif hash apt-get 2>/dev/null; then
      # Debian/Ubuntu
      export DEBIAN_FRONTEND=noninteractive
      apt-get -y update || true
      apt-get -y install sudo || true
      sudo -E apt-get -y update
      sudo -E apt-get -y upgrade
      sudo -E apt-get -y install build-essential libpam-systemd direnv
      pacman_bin="DEBIAN_FRONTEND=noninteractive apt-get -y install"
      pynvim_pkg="python3-neovim"
  else
      pacman_bin=/bin/false
  fi

  # install basic packages
  sudo $pacman_bin git neovim ${pynvim_pkg} zsh tmux htop zip unzip xsel curl trash-cli fzf ripgrep tldr ranger
fi

# get submodules
git submodule init
git submodule update --recursive

# copy vim config
ln -srfv _vimrc ~/.vimrc

ln -srfTv oh-my-zsh ~/.oh-my-zsh
ln -srfTv oh-my-zsh-custom ~/.oh-my-zsh-custom

# set zsh as the default shell
current_shell=$(expr "${SHELL:=/bin/false}" : '.*/\(.*\)')
if [ "$current_shell" != "zsh" ]; then
  zsh_shell="$(grep /zsh$ /etc/shells | tail -1)"
  echo "Changing default shell to ${zsh_shell}"
  chsh -s "${zsh_shell}"
fi

# copy zsh config
ln -srfv _zshrc ~/.zshrc
ln -srfv _zprofile ~/.zprofile
ln -srfv _zshenv ~/.zshenv

# copy tmux config
ln -srfv _tmux.conf ~/.tmux.conf

# copy clang-format
ln -srfv _clang-format ~/.clang-format

# copy git config
ln -srfv _gitconfig ~/.gitconfig

# copy binaries
mkdir -vp ~/bin
ln -srfv bin/* ~/bin/
