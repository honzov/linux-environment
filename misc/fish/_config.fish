if status is-interactive
    # Commands to run in interactive sessions can go here
end

#################################
# ALIASES
alias o='xdg-open'
alias r='source /usr/bin/ranger'
alias unp='unp -U'
alias mv='mv -i'
alias rm='rm -i'
alias bat='batcat'
alias books='cd ~/Documents/books'
alias school='cd ~/Documents/school'
alias r='ranger-cd'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias arch-update='yay -Syu --combinedupgrade --noremovemake --answerclean=All --sudoloop'
alias pacman-prune='sudo pacman -Rns $(pacman -Qtdq)'

# git
alias gl-all='git submodule sync --recursive && git pull && git submodule update --recursive --remote'
#################################

set -gx PATH $HOME/bin $PATH
set -gx EDITOR vim
set -gx VISUAL vim

