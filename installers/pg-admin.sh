#!/bin/bash

# Short and meaningful installer description, describing the app being installed.
pg-admin_description() {
  echo "phAdmin 4 - PostgreSQL Tools"
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
pg-admin_installed() {
  command -v pgadmin 2>&1 > /dev/null
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
pg-admin_pre_install() {
  local codename=$(cat /etc/upstream-release/lsb-release | grep DISTRIB_CODENAME | cut -d = -f 2)

  if [[ -f /etc/apt/sources.list.d/pg-admin4.list ]]; then
    sudo rm /etc/apt/sources.list.d/pg-admin4.list
  fi

  curl -fsSL https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --yes --dearmor --output /etc/apt/keyrings/pgadmin-org.gpg &&
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$codename pgadmin4 main" | sudo tee /etc/apt/sources.list.d/pg-admin4.list &&
    sudo apt-get update
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
pg-admin_install() {
  if command -v apt-fast 2>&1 > /dev/null; then
    sudo apt-fast -y install pgadmin4-desktop
  else
    sudo apt-get -y install pgadmin4-desktop
  fi
}

# Called after installation completed successfully
# Post installation may contains user interactive session
pg-admin_post_install() {
  return 0
}

