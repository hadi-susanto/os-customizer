#!/bin/bash

if [[ -z "$TLP_UI_INSTALL_DIR" ]]; then
  # Unless defined we will assume tlp-ui cloned as our directory siblings
  TLP_UI_INSTALL_DIR=$(readlink -f "$PWD/..")/tlp-ui
fi

if command -v python3 2>&1 > /dev/null; then
  TLP_UI_PYTHON3_AVAILABLE=true
fi

# Short and meaningful installer description, describing the app being installed.
tlp_description() {
  echo "Advanced Laptop Battery Management (CLI) and 3rd party UI apps (have python 3.9 as minimum dependency)"
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
tlp_installed() {
  command -v tlp 2>&1 > /dev/null
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
tlp_pre_install() {
  sudo apt-get update
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
tlp_install() {
  echo "Installing tlp and tlp-rdw..."
  if command -v apt-fast 2>&1 > /dev/null; then
    sudo apt-fast -y install tlp tlp-rdw
  else
    sudo apt-get -y install tlp tlp-rdw
  fi

  if [[ -z "$TLP_UI_PYTHON3_AVAILABLE" ]]; then
    echo "Python 3 not found, skipping installing TLPUI, you can still use tlp CLI"

    return 0
  fi

  echo "Installing TLPUI (tlp UI using GTK lib) into $TLP_UI_INSTALL_DIR"
  echo "Cloning https://github.com/d4nj1/TLPUI..."
  git clone --depth 1 https://github.com/d4nj1/TLPUI.git "$TLP_UI_INSTALL_DIR"
}

# Called after installation completed successfully
# Post installation may contains user interactive session
tlp_post_install() {
  echo "Enabling tlp.service..."
  sudo systemctl enable --now tlp.service
  systemctl status tlp.service
}

# Optional to implements, this method called once all installation done
# Useful to print informational message to users
tlp_post_install_message() {
  cat <<EOF
Congratulations tlp CLI installed, please ensure your laptop battery supported.
To check whether your laptop battery supported or not:
    sudo tlp-stat --battery

Please check for loaded plugin and its capability. If your battery supported,
you can start tinkering with its config by issuing command:
    sudo nano /etc/tlp.conf
EOF

  echo
  if [[ -z "$TLP_UI_PYTHON3_AVAILABLE" ]]; then
    echo "WARNING: Python 3 wasn't found, we skipping installing https://github.com/d4nj1/TLPUI."
    echo "Once you install Python 3, you can clone by issuing following command:"
    echo "    git clone --depth 1 https://github.com/d4nj1/TLPUI [/path/to/install]"
  else
    echo "TLPUP installed at $TLP_UI_INSTALL_DIR"
    echo "Usage: run following command from install directory"
    echo "    python3 -m tlpui"
  fi
}

