#!/bin/bash

# Short and meaningful installer description, describing the app being installed.
apt-fast_describe() {
  echo "Description of apt-fast installation and configuration"
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
apt-fast_pre_install() {
  echo "apt-fast_pre_install called"

  return 0
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
apt-fast_install() {
  echo "apt-fast_manual_install called"

  return 0
}

# Called after installation completed successfully
# Post installation may contains user interactive session
apt-fast_post_install() {
  echo "apt-fast_post_install called"

  return 0
}

