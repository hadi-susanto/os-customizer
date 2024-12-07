#!/bin/bash

# Short and meaningful installer description, describing the app being installed.
anydesk_description() {
  echo "AnyDesk, remote any computer with ease, similar to TeamViewer"
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
anydesk_installed() {
  command -v template 2>&1 > /dev/null
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
anydesk_pre_install() {
  if [[ -f /etc/apt/sources.list.d/anydesk-stable.list ]]; then
    sudo rm /etc/apt/sources.list.d/anydesk-stable.list
  fi

  curl -fsSL https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo gpg --yes --dearmor --output /etc/apt/keyrings/anydesk.gpg &&
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list &&
    sudo apt-get update
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
anydesk_install() {
  if command -v apt-fast 2>&1 > /dev/null; then
    sudo apt-fast -y install anydesk
  else
    sudo apt-get -y install anydesk
  fi
}

# Called after installation completed successfully
# Post installation may contains user interactive session
anydesk_post_install() {
  return 0
}

