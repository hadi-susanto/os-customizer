#!/bin/bash

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
apt-fast_installed() {
  command -v cryptomator 2>&1 > /dev/null
}

# Short and meaningful installer description, describing the app being installed.
cryptomator_describe() {
  echo "Store your private file securely even without disk encryption!"
  echo "Encryption done per file basis, don't need to create a dedicated secured container."
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
cryptomator_pre_install() {
  sudo add-apt-repository -y ppa:sebastian-stenzel/cryptomator && sudo apt-get update
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
cryptomator_install() {
  if command -v apt-fast 2>&1 > /dev/null; then
    sudo apt-fast -y install cryptomator
  else
    sudo apt-get -y install cryptomator
  fi
}

# Called after installation completed successfully
# Post installation may contains user interactive session
cryptomator_post_install() {
  return 0
}

# Optional function / method
# Called after all installers successfuly installed. Used to inform user action once activity done.
cryptomator_post_install_message() {
  echo "Please install license from OneDrive to enable dark theme."
}

