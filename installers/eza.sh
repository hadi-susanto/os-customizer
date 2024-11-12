#!/bin/bash

# Short and meaningful installer description, describing the app being installed.
apt-fast_describe() {
  echo "eza a an ls supercharged! it have better presentation"
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
apt-fast_pre_install() {
  curl -fsSL https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor --output /etc/apt/keyrings/eza-gierens.gpg &&
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/eza-gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/eza-gierens.list &&
    sudo apt-get update
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
apt-fast_install() {
  sudo apt-get install eza
}

# Called after installation completed successfully
# Post installation may contains user interactive session
apt-fast_post_install() {
  return 0
}

