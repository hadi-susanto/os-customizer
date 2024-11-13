#!/bin/bash

# Global variables
if [[ "${OSC_AUTO_YES}" != "true" ]]; then
  OSC_AUTO_YES="false"
fi

# https://rowannicholls.github.io/bash.html
cat <<EOF
OS Customizer ZSH Theme Installer
---------------------------------

EOF

if [[ "${OSC_AUTO_YES}" != "true" ]]; then
  # https://stackoverflow.com/questions/18544359/how-do-i-read-user-input-into-a-variable-in-bash
  read -p "It will modify your ~/.zshrc, continue? (y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
fi

# Backup current
suffix=$(date +%Y%m%d-%H%M%S)
echo "Backup your ~/.zshrc to ~/.zshrc.bak-$suffix"
cp ~/.zshrc ~/.zshrc.bak-$suffix
echo "done"
echo
 
# Rewriting ~/.zshrc
echo "Writing OS Customizer to ~/.zshrc ..."
cat>~/.zshrc <<EOF
# OS Customizer installation script
# 1. OS_CUSTOMIZER_BASE_PATH should point to root directory of os-customizer repository
# 2. Adjust PLUGINS variable as needed, currently: git, eza, bat are defaults
OS_CUSTOMIZER_BASE_PATH=\"$PWD\"
PLUGINS=(git eza bat)
source "${OS_CUSTOMIZER_BASE_PATH}/zsh/custom.zsh-theme"

EOF

echo "Appending .zshrc.bak-$suffix to customized .zshrc ..."
cat ~/.zshrc.bak-$suffix >> ~/.zshrc
echo "Done, please check your ~/.zshrc"

if [[ "${OSC_AUTO_YES}" != "true" ]]; then
  read -p "Do you want to remove backup file? (y/N: )" confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 0
fi

rm ~/.zshrc.bak-$suffix
echo "~/.zshrc.bak-$suffix removed"

