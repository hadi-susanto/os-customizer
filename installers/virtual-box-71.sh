#!/bin/bash

# Short and meaningful installer description, describing the app being installed.
virtual-box-71_description() {
  echo "Oracle VirtualBox 7.1"
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
virtual-box-71_installed() {
  command -v virtualbox 2>&1 > /dev/null
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
virtual-box-71_pre_install() {
  local codename=$(cat /etc/upstream-release/lsb-release | grep DISTRIB_CODENAME | cut -d = -f 2)

  if [[ -f /etc/apt/sources.list.d/oracle-virtualbox.list ]]; then
    sudo rm /etc/apt/sources.list.d/oracle-virtualbox.list
  fi

  curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --dearmor --output /etc/apt/keyrings/oracle-virtualbox.gpg &&
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/oracle-virtualbox.gpg] https://download.virtualbox.org/virtualbox/debian $codename contrib" | sudo tee /etc/apt/sources.list.d/oracle-virtualbox.list &&
    sudo apt-get update
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
virtual-box-71_install() {
  if command -v apt-fast 2>&1 > /dev/null; then
    sudo apt-fast -y install virtualbox-7.1
  else
    sudo apt-get -y install virtualbox-7.1
  fi
}

# Called after installation completed successfully
# Post installation may contains user interactive session
virtual-box-71_post_install() {
  return 0
}

# Optional to implements, this method called once all installation done
# Useful to print informational message to users
virtual-box-71_post_install_message() {
  cat <<EOF
Please download virtualbox extensions pack at https://www.virtualbox.org/wiki/Downloads.
Ensure extension pack version equal to installed virtualbox version
EOF
}

