#!/bin/bash

# Short and meaningful installer description, describing the app being installed.
zsh_description() {
  echo "zsh is bash replacement, it's offer more feature compared to bash."
}


# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
zsh_installed() {
  command -v zsh 2>&1 > /dev/null
}
# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
zsh_pre_install() {
  sudo apt-get update
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
zsh_install() {
  if command -v apt-fast 2>&1 > /dev/null; then
    sudo apt-fast -y install zsh
  else
    sudo apt-get -y install zsh
  fi
}

# Called after installation completed successfully
# Post installation may contains user interactive session
zsh_post_install() {
  echo "Changing current shell ($SHELL) to zsh ($(which zsh))"
  if [[ -z "${SUDO_USER}" ]]; then
    chsh -s $(which zsh)
  else
    chsh -s $(which zsh) $SUDO_USER
  fi
}

