# install all utils
source ./core_tools

# change default shell
chsh -s /usr/bin/fish
set -U fish_greeting
cp ./fish/config.fish ~/.config/fish/

# enable fzf bindings from the doc
mkdir -p ~/.config/fish/functions/
echo fzf_key_bindings > ~/.config/fish/functions/fish_user_key_bindings.fish

# fisher
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install jethrokuan/z
fisher install sei40kr/fish-ranger-cd

