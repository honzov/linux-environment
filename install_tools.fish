#!/bin/fish

set base_tools git neovim tmux htop zip unzip curl xsel ranger fzf tldr man ripgrep
set full_tools python docker cmake unp gpaste net-tools virtualbox

function install_arch
    set arch_install_comm sudo pacman -S --noconfirm --needed
    eval $arch_install_comm archlinux-keyring
    sudo pacman -Syu --noconfirm
    if test $level -ge 0
        echo Installing level 0
        $arch_install_comm $base_tools
    end
    if test $level -ge 1
        echo Installing level 1
        $arch_install_comm $full_tools
    end
    if test $level -ge 2
        echo Installing level 2
        set aur_comm yay -S --noconfirm --needed
        set aur_reps google-chrome visual-studio-code-bin
        gsettings set org.gnome.shell.app-switcher current-workspace-only true
        cd /tmp
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm --needed
        yay -Syu --noconfirm
        eval $aur_comm $aur_reps
    end
end

function install_ubuntu
    sudo apt-get -y update
    if test $level -ge 0
        sudo apt-get install $base_tools
    end
    if test $level -ge 1
        sudo apt-get install $full_tools
    end
end

function install_tools
    if apt-get --version &> /dev/null
        install_ubuntu
    else if pacman --version &> /dev/null
        install_arch
    end
end

echo STARTING INSTALLATION
set input $argv[1]
set level 0
if test -n $input -a $input -gt $level
    set level $input
end
install_tools


