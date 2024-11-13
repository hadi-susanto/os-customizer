#!/bin/bash

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
dconf-editor_installed() {
  command -v dconf-editor 2>&1 > /dev/null
}

# Short and meaningful installer description, describing the app being installed.
dconf-editor_describe() {
  echo "DRAGON AHEAD: dconf-editor capable to edit system variables, use carefully"
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
dconf-editor_pre_install() {
  sudo apt-get update
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
dconf-editor_install() {
  sudo apt-get -y install dconf-editor
}

# Called after installation completed successfully
# Post installation may contains user interactive session
dconf-editor_post_install() {
  return 0
}

# Optional function / method
# Called after all installers successfuly installed. Used to inform user action once activity done.
dconf-editor_post_install_message() {
  cat << EOF
TIPS:
* For battery settings: /org/cinnamon/settings-daemon/plugins/power/
EOF
}

