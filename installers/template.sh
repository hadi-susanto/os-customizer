#!/bin/bash

# Short and meaningful installer description, describing the app being installed.
template_description() {
  echo "Description app being installed, can have long description"
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
template_installed() {
  command -v template 2>&1 > /dev/null
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
template_pre_install() {
  return 0
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
template_install() {
  return 0
}

# Called after installation completed successfully
# Post installation may contains user interactive session
template_post_install() {
  return 0
}

# Optional to implements, this method called once all installation done
# Useful to print informational message to users
template_post_install_message() {
  cat <<EOF
Altough this method can be used for post install action once everything done,
it's discouraged to be used in such case.
EOF
}

