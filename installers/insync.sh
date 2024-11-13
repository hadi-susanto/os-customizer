#!/bin/bash

# Short and meaningful installer description, describing the app being installed.
insync_describe() {
  echo "Sync your OneDrive, Google Drive with insync (Cloud Storage Client)"
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
insync_pre_install() {
  curl -fsSL "https://keyserver.ubuntu.com/pks/lookup?search=0xACCAF35C&fingerprint=on&op=get" | sudo gpg --dearmor --output /etc/apt/keyrings/insync.gpg &&
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/insync.gpg] http://apt.insync.io/mint $(lsb_release -c -s) non-free contrib" | sudo tee /etc/apt/sources.list.d/insync.list &&
    sudo apt-get update
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
insync_install() {
  sudo apt-get install insync
}

# Called after installation completed successfully
# Post installation may contains user interactive session
insync_post_install() {
  return 0
}

# Optional function / method
# Called after all installers successfuly installed. Used to inform user action once activity done.
insync_post_install_message() {
  echo "insync have File Manager helper to put badges in your file as sync status indicator."
  echo "It wasn't really useful so it wasn't installed by default, manual installation is required."
  echo "Nemo File Manager: sudo apt-get install insync-nemo"
}

