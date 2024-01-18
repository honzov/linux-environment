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

alias arch-update='yay -Syu --combinedupgrade --noremovemake --noupgrademenu --nodiffmenu --answerclean=All --sudoloop'
alias pacman-prune='sudo pacman -Rns $(pacman -Qtdq)'

# Docker
alias docker-prune='docker system prune'
alias docker-prune-old='docker image prune --all --filter "until=168h"'
alias docker-rm-containers="docker rm $(docker ps -a | grep Exited | grep -v CON | awk '{print $1}')"
alias docker-show-dangling='docker images --quiet --filter "dangling=true"'
alias docker-rm-dangling='docker images -qf dangling=true | xargs docker rmi'
alias docker-pull-all="docker images | grep -v REPOSITORY | awk '{print \$1 \":\" \$2}' | grep -v '<none>:<none>' | xargs -I '{}' docker pull '{}'"

# git
alias gl-all='git submodule sync --recursive && git pull && git submodule update --recursive --remote'
#################################

set -gx PATH $HOME/bin $PATH
set -gx EDITOR vim
set -gx VISUAL vim

