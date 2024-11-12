#!/bin/bash

# Short and meaningful installer description, describing the app being installed.
apt-fast_describe() {
  echo "apt-fast is wrapper for apt or apt-get package manager, apt-fast will enable faster downloads"
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
apt-fast_pre_install() {
  sudo add-apt-repository -y ppa:apt-fast/stable && sudo apt-get update
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
apt-fast_install() {
  sudo apt-get -y install apt-fast
}

# Called after installation completed successfully
# Post installation may contains user interactive session
apt-fast_post_install() {
  return 0
}

