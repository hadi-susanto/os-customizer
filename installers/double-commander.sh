#!/bin/bash

# Short and meaningful installer description, describing the app being installed.
double-commander_description() {
  echo "Dual pane file manager, use TAB key to switch between pane, managing file never been easier"
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
double-commander_installed() {
  command -v doublecmd 2>&1 > /dev/null
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
double-commander_pre_install() {
  echo "Checking Ubuntu version..."
  version=$(cat /etc/upstream-release/lsb-release | grep DISTRIB_RELEASE | cut -d = -f 2)
  codename="xUbuntu_$version"

  curl -fsSL "https://download.opensuse.org/repositories/home:Alexx2000/$codename/Release.key" | sudo gpg --yes --dearmor --output /etc/apt/keyrings/double-commander.gpg &&
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/double-commander.gpg] http://download.opensuse.org/repositories/home:/Alexx2000/$codename/ /" | sudo tee /etc/apt/sources.list.d/double-commander.list &&
    sudo apt-get update
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
double-commander_install() {
  if command -v apt-fast 2>&1 > /dev/null; then
    sudo apt-fast -y install doublecmd-gtk
  else
    sudo apt-get -y install doublecmd-gtk
  fi
}

# Called after installation completed successfully
# Post installation may contains user interactive session
double-commander_post_install() {
  return 0
}

# Optional to implements, this method called once all installation done
# Useful to print informational message to users
double-commander_post_install_message() {
  cat <<EOF
* Once installation done, you can change your "Default Application" or "Preferred Application" to doublecmd to override Super + E / Winkey + E shortcut.
* Open menu Configuration > Options... then search for splash and disable 'Splash Screen', enjoy.
EOF
}

