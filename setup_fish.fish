#!/bin/fish

chsh -s /usr/bin/fish
fish
set -U fish_greeting
cp ./fish/config.fish ~/.config/fish/
fish_config prompt choose informative_vcs

# fisher
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install jethrokuan/z
fisher install sei40kr/fish-ranger-cd

# enable fzf bindings from the doc
mkdir -p ~/.config/fish/functions/
echo fzf_key_bindings > ~/.config/fish/functions/fish_user_key_bindings.fish


