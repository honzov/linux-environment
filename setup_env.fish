#!/bin/fish

cp _tmux.conf ~/.tmux.conf
cp _clang-format ~/.clang-format
cp _gitconfig ~/.gitconfig
cp _config.fish ~/.config/fish/config.fish

ssh-keygen -t ed25519 -C "jirak.honza@seznam.cz" -f ~/.ssh/ed25519-key

chsh -s /bin/fish
set -U fish_greeting
if test -n "$argv[1]" -a "$argv[1]" = "--main"
    fish_config prompt save informative_vcs 
end
# fisher
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install jethrokuan/z
fisher install sei40kr/fish-ranger-cd

# enable fzf bindings from the doc
mkdir -p ~/.config/fish/functions/
echo fzf_key_bindings > ~/.config/fish/functions/fish_user_key_bindings.fish
