#!/bin/bash

if [[ -z "$DOCKER_VAR_LIB_DIR" ]]; then
  # Unless defined we will assume /var/lib/docker will be moved into os-customizer sibling folder
  DOCKER_VAR_LIB_DIR=$(readlink -f "$PWD/..")/docker-lib
fi

# Short and meaningful installer description, describing the app being installed.
docker_description() {
  echo "Docker Container, it will automatically set /var/lib/docker to $DOCKER_VAR_LIB_DIR"
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
docker_installed() {
  command -v docker 2>&1 > /dev/null
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
docker_pre_install() {
  local codename=$(cat /etc/upstream-release/lsb-release | grep DISTRIB_CODENAME | cut -d = -f 2)

  if [[ -f /etc/apt/sources.list.d/docker.list ]]; then
    sudo rm /etc/apt/sources.list.d/docker.list
  fi

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --yes --dearmor --output /etc/apt/keyrings/docker.gpg &&
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $codename stable" | sudo tee /etc/apt/sources.list.d/docker.list &&
    sudo apt-get update
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
docker_install() {
  if command -v apt-fast 2>&1 > /dev/null; then
    sudo apt-fast -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  else
    sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  fi
}

# Called after installation completed successfully
# Post installation may contains user interactive session
docker_post_install() {
  echo "Now we will moving /var/lib/docker to $DOCKER_VAR_LIB_DIR"

  echo "Stopping docker..."
  sudo systemctl stop docker

  echo "Copying /var/lib/docker to $DOCKER_VAR_LIB_DIR"
  rsync -avP /var/lib/docker/ "$DOCKER_VAR_LIB_DIR"

  if [[ -f "/etc/docker/daemon.json" ]]; then
    echo "Existing /etc/docker/daemon.json was found, installer WILL NOT touch it"
    echo "Please check it manually and ensure there is data-root key in the json file"
  else
    echo "Writing /etc/docker/daemon.json"
    sudo cat>/etc/docker/daemon.json <<EOF
{
  "data-root": "$DOCKER_VAR_LIB_DIR"
}
EOF
  fi

  echo "Restart docker..."
  sudo systemctl start docker
}

# Optional to implements, this method called once all installation done
# Useful to print informational message to users
docker_post_install_message() {
  cat <<EOF
Docker successfully installed, and please check your /ect/docker/daemon.json file.
NOTE: We don't remove /var/lib/docker, if you want to remove it please do it manually.
EOF
}

