#!/bin/bash

# Short and meaningful installer description, describing the app being installed.
microsoft-edge_description() {
  echo "Microsoft Edge Browser (Stable Release) - Chromium based browser with vertical tab"
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
microsoft-edge_installed() {
  command -v microsoft-edge 2>&1 > /dev/null
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
microsoft-edge_pre_install() {
  codename=$(cat /etc/upstream-release/lsb-release | grep DISTRIB_CODENAME | cut -d = -f 2)

  if [[ -f /etc/apt/sources.list.d/microsoft-edge.list ]]; then
    sudo rm /etc/apt/sources.list.d/microsoft-edge.list
  fi

  curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --yes --dearmor --output /etc/apt/keyrings/microsoft.gpg &&
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main" | sudo tee /etc/apt/sources.list.d/microsoft-edge.list &&
    sudo apt-get update
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
microsoft-edge_install() {
  if command -v apt-fast 2>&1 > /dev/null; then
    sudo apt-fast -y install microsoft-edge-stable
  else
    sudo apt-get -y install microsoft-edge-stable
  fi
}

# Called after installation completed successfully
# Post installation may contains user interactive session
microsoft-edge_post_install() {
  echo "Disabling microsoft edge auto updater... (Auto updater will changing our source.list.d)"
  sudo chmod -x /opt/microsoft/msedge/cron/microsoft-edge
}

# Optional to implements, this method called once all installation done
# Useful to print informational message to users
microsoft-edge_post_install_message() {
  cat <<EOF
Microsof edge is adding daily cron job to perform auto update, it's updater will change our
/etc/apt/sources.list.d/microsoft-edge.list and it breaking since DON'T put microsoft gpg key
as globally recognized, our installer automatically disabling it, but manual update from any
package manager will cause cron re-enabled. Please always disable it by issuing:

    chmod -x /opt/microsoft/msedge/cron/microsoft-edge

Thank You microsoft...
EOF
}

