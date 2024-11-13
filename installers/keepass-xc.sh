#!/bin/bash

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
apt-fast_installed() {
  command -v keepassxc 2>&1 > /dev/null
}

# Short and meaningful installer description, describing the app being installed.
keepass-xc_describe() {
  echo "KeePassXC is KeePass compatible client to store your password securely."
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
keepass-xc_pre_install() {
  sudo add-apt-repository -y ppa:phoerious/keepassxc && sudo apt-get update
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
keepass-xc_install() {
  if command -v apt-fast 2>&1 > /dev/null; then
    sudo apt-fast -y install keepassxc
  else
    sudo apt-get -y install keepassxc
  fi
}

# Called after installation completed successfully
# Post installation may contains user interactive session
keepass-xc_post_install() {
  return 0
}
