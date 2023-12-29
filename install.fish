#!/bin/fish

set basic_tools git neovim tmux htop zip unzip curl xsel
set full_tools fzf tweaks python-3 ripgrep docker cmake unp ranger gpaste \
    wireshark net-tools rar  unrar virtualbox gnome-tweak-tool tldr man

function install_tools
    if apt-get --version &> /dev/null
        sudo apt-get -y update 
        set install_comm "sudo apt-get install"
    else if pacman --version &> /dev/null
        sudo pacman -Syu --noconfirm
        set install_comm "sudo pacman -Suy --noconfirm"
    end
    for i in $basic_tools
        eval "$install_comm $i"
    end
    if test -n "$argv[1]" -a "$argv[1]" = "--full"
        for i in $full_tools
            eval "$install_comm $i"
        end  
    end
end

echo STARTING INSTALLATION
install_tools $argv[1]

cp _tmux.conf ~/.tmux.conf
cp _clang-format ~/.clang-format
cp _gitconfig ~/.gitconfig

