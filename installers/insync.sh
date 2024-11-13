#!/bin/bash

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
insync_installed() {
  command -v insync 2>&1 > /dev/null
}

# Short and meaningful installer description, describing the app being installed.
insync_describe() {
  echo "Sync your OneDrive, Google Drive with insync (Cloud Storage Client)"
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
insync_pre_install() {
  curl -fsSL "https://keyserver.ubuntu.com/pks/lookup?search=0xACCAF35C&fingerprint=on&op=get" | sudo gpg --yes --dearmor --output /etc/apt/keyrings/insync.gpg &&
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/insync.gpg] http://apt.insync.io/mint $(lsb_release -c -s) non-free contrib" | sudo tee /etc/apt/sources.list.d/insync.list &&
    sudo apt-get update
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
insync_install() {
  if command -v apt-fast 2>&1 > /dev/null; then
    sudo apt-fast -y install insync
  else
    sudo apt-get -y install insync
  fi
}

# Called after installation completed successfully
# Post installation may contains user interactive session
insync_post_install() {
  return 0
}

# Optional function / method
# Called after all installers successfuly installed. Used to inform user action once activity done.
insync_post_install_message() {
  cat << EOF
FYI: insync have additional app as file manager helper, this app will add badge to your
file manager to indicate sync status. This app is vary based on File Managers.

Supported File Manager:
- Caja:     sudo apt-get install insync-caja
- Dolphin:  sudo apt-get install insync-dolphin
- Nautilus: sudo apt-get install insync-nautilus
- Nemo:     sudo apt-get install insync-nemo
- Thunar:   sudo apt-get install insync-thunar

More info visit: https://www.insynchq.com/downloads/linux
EOF
}

