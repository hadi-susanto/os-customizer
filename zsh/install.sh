#!/bin/bash

# https://rowannicholls.github.io/bash.html
echo "OS Customizer ZSH Theme Installer"
echo "---------------------------------"
echo

# https://stackoverflow.com/questions/18544359/how-do-i-read-user-input-into-a-variable-in-bash
read -p "It will modify your ~/.zshrc, continue? (y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

# Backup current
suffix=$(date +%Y%m%d-%H%M%S)
echo "Backup your ~/.zshrc to ~/.zshrc.bak-$suffix"
cp ~/.zshrc ~/.zshrc.bak-$suffix
echo "done"
echo
 
# Rewriting ~/.zshrc
echo "Writing OS Customizer to ~/.zshrc ..."
echo "# OS Customizer installation script" > ~/.zshrc
echo "# 1. OS_CUSTOMIZER_BASE_PATH should point to root directory of os-customizer repository" >> ~/.zshrc
echo "# 2. Adjust PLUGINS variable as needed, currently: git, eza, bat are defaults" >> ~/.zshrc
echo "OS_CUSTOMIZER_BASE_PATH=\"$PWD\"" >> ~/.zshrc
echo "PLUGINS=(git eza bat)" >> ~/.zshrc
echo 'source "${OS_CUSTOMIZER_BASE_PATH}/zsh/custom.zsh-theme"' >> ~/.zshrc
echo >> ~/.zshrc

echo "Appending .zshrc.bak-$suffix to customized .zshrc ..."
cat ~/.zshrc.bak-$suffix >> ~/.zshrc

echo "Done, please check your ~/.zshrc"
read -p "Do you want to remove backup file? (y/N: )" confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 0

rm ~/.zshrc.bak-$suffix
echo "~/.zshrc.bak-$suffix removed"

