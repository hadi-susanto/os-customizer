#!/bin/bash

# Variables
flameshot_temp_folder=""

# Short and meaningful installer description, describing the app being installed.
flameshot_description() {
  echo "Screenshot with basic editor"
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
flameshot_installed() {
  command -v flameshot 2>&1 > /dev/null
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
flameshot_pre_install() {
  echo "Checking Ubuntu version..."
  version=$(cat /etc/upstream-release/lsb-release | grep DISTRIB_RELEASE | cut -d = -f 2)
  case $version in
    "20.04" | "22.04")
      echo "Ubuntu ver. $version is supported, generating download link."
      ;;
    *)
      echo "New Ubuntu base? Unsupported ver. $version, please update installers/flameshot.sh first."
      return 1
      ;;
  esac

  echo "Generating latest bat.deb download link..."
  # Need to remove .sha256sum since it have similar signature with actual .deb file
  link=$(curl -s https://api.github.com/repos/flameshot-org/flameshot/releases/latest | grep "browser_download_url.*deb" | grep "ubuntu-$version.*amd64" | grep -v "sha256sum" | cut -d : -f 2,3 | tr -d \")

  if [[ -z $link ]]; then
    echo "Failed to retrieve flameshot latest release, please retry again or check download link if issue persistent"

    return 1
  fi

  flameshot_temp_folder=$(mktemp -d)
  echo "Downloading from: '$link' to '$flameshot_temp_folder/flameshot_latest.deb'"
  echo $link | wget -nv --show-progress -i - -O "$flameshot_temp_folder/flameshot_latest.deb"

  if [[ -f "$flameshot_temp_folder/flameshot_latest.deb" ]]; then
    echo "Download success!"

    return 0
  else
    echo "Download failed!"

    return 1
  fi
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
flameshot_install() {
  sudo dpkg -i "$flameshot_temp_folder/flameshot_latest.deb"

  return 0
}

# Called after installation completed successfully
# Post installation may contains user interactive session
flameshot_post_install() {
  rm -r $flameshot_temp_folder

  return 0
}

