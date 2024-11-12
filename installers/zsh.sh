#!/bin/zsh

# Short and meaningful installer description, describing the app being installed.
zsh_describe() {
  echo "zsh is bash replacement, it's offer more feature compared to bash."
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
zsh_pre_install() {
  sudo apt-get update
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
zsh_install() {
  sudo apt-get -y install zsh
}

# Called after installation completed successfully
# Post installation may contains user interactive session
zsh_post_install() {
  echo -e "\nChanging current shell ($SHELL) to zsh ($(which zsh)"
  if [[ -z "${SUDO_USER}" ]]; then
    chsh -s $(which zsh) $SUDO_USER
  else
    chsh -s $(which zsh)
  fi
}

