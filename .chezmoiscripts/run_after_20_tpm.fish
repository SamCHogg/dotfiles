#!/usr/bin/env fish

# Installs tpm if not installed and runs install_plugins script
echo -e "\033[0;32m>>>>> Begin Setting Up Tmux Plugins <<<<<\033[0m"
if ! test -d ~/.tmux/plugins/tpm
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
end

~/.tmux/plugins/tpm/bin/install_plugins

echo -e "\033[0;32m>>>>> Finish Setting Tmux Plugins <<<<<\033[0m"
