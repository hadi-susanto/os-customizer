#!/bin/bash

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
apt-fast_installed() {
  command -v terminator 2>&1 > /dev/null
}

# Short and meaningful installer description, describing the app being installed.
terminator_describe() {
  echo "terminator is gnome terminal replacement, terminator come with split pane functionality"
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
terminator_pre_install() {
  sudo add-apt-repository -y ppa:mattrose/terminator && sudo apt-get update
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
terminator_install() {
  if command -v apt-fast 2>&1 > /dev/null; then
    sudo apt-fast -y install terminator
  else
    sudo apt-get -y install terminator
  fi
}

# Called after installation completed successfully
# Post installation may contains user interactive session
terminator_post_install() {
  return 0
}

