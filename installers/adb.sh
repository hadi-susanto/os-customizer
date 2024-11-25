#!/bin/bash

# Global Variable(s)
if [[ -z "$ADB_INSTALL_DIR" ]]; then
  # Unless defined we will assume sdkman cloned as our directory siblings
  ADB_INSTALL_DIR=$(readlink -f "$PWD/..")/adb
fi

adb_temp_dir=""
adb_version="n.a."

# Short and meaningful installer description, describing the app being installed.
adb_description() {
  echo "Android Debug Bridge (adb)"
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
adb_installed() {
  if [[ -d "$ADB_INSTALL_DIR" ]]; then
    return 0
  else
    return 1
  fi
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
adb_pre_install() {
  adb_temp_dir=$(mktemp -d)

  local link="https://dl.google.com/android/repository/platform-tools-latest-linux.zip"
  echo "Downloading latest adb tools from $link"
  echo $link | wget -nv --show-progress -i - -O "$adb_temp_dir/adb.zip"
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
adb_install() {
  unzip "$adb_temp_dir/adb.zip" -d $adb_temp_dir
  adb_version=$("$adb_temp_dir"/platform-tools/adb --version | grep "Android Debug Bridge version" | cut -d " " -f 5)

  if [[ -d "$ADB_INSTALL_DIR-$adb_version" ]]; then
    echo "Previous installation folder found, removing: $ADB_INSTALL_DIR-$adb_version"
    rm -r "$ADB_INSTALL_DIR-$adb_version"
  fi

  mkdir "$ADB_INSTALL_DIR-$adb_version" &&
    cp -r -v "$adb_temp_dir"/platform-tools/* "$ADB_INSTALL_DIR-$adb_version/" &&
    ln -s -d "$ADB_INSTALL_DIR-$adb_version" "$ADB_INSTALL_DIR"
}

# Called after installation completed successfully
# Post installation may contains user interactive session
adb_post_install() {
  rm -r $adb_temp_dir
}

# Optional to implements, this method called once all installation done
# Useful to print informational message to users
adb_post_install_message() {
  cat <<EOF
WARNING: 
 * adb tools isn't added to your shell PATH environment variable !!!
 * $ADB_INSTALL_DIR is a symbolic link to $(readlink -f "$ADB_INSTALL_DIR")
 * Symbolic link used for easy rollback mechanism
 * Please go to $ADB_INSTALL_DIR, and execute adb command from it.
EOF
}

