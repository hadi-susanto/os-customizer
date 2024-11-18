#!/bin/bash

# Global variable
OSC_LOADER_FILE="$PWD/osc-loader.sh"

# Short and meaningful installer description, describing the app being installed.
zsh-plugins_description() {
  cat <<EOF
This is another ZSH theme or maybe a plugin for your ZSH,
this plugin will be very biased because it created based on my workflow.
It add some shortcut and aliases to most common used apps such as git,eza, bat.
The plugin also can be found in current repository, this may copied the zsh/install.sh
EOF
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
zsh-plugins_installed() {
  # Always return not installed, we will handle, the installer will always update plugins installation
  return 1
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
zsh-plugins_pre_install() {
  # Install our loader...
  local dot_file;
  dot_file=$(zsh-plugins_detect_dot_file)
  echo "Checking $dot_file for loader existence..."

  if ! [[ -f $dot_file ]]; then
    echo "Unable to install OS Customizer zsh plugins, please re-run after zsh properly installed and have been configured"

    return 1
  fi

  if [[ -n $(grep "# OS Customizer Loader" $dot_file) ]]; then
    echo "OS Customizer zsh plugins loader found in, skip loader installation."

    return 0
  fi

  zsh-plugins_install_loader $dot_file
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
zsh-plugins_install() {
  if [[ -f $OSC_LOADER_FILE ]]; then
    echo "Previous OS Customizer loader found, deleting..."
    rm $OSC_LOADER_FILE
  fi

  echo "Writing $OSC_LOADER_FILE ..."
  cat>"$OSC_LOADER_FILE" <<EOF
# Basic functionality, must available in every linux distribution
source "$PWD/zsh/common.plugin.sh"

# Start loading plugins based on local computer package availability
EOF

  for file in "$PWD"/zsh/*.plugin.sh; do
    if ! [[ -f $file ]]; then
      echo "WARNING: Not a file $file"

      continue
    fi

    if [[ $file != "$PWD/zsh/common.plugin.sh" ]]; then
      zsh-plugins_install_plugin $file
    fi
  done

  echo >> "$OSC_LOADER_FILE"
}

# Called after installation completed successfully
# Post installation may contains user interactive session
zsh-plugins_post_install() {
  return 0
}

# Optional function / method
# Called after all installers successfuly installed. Used to inform user action once activity done.
zsh-plugins_post_install_message() {
  cat <<EOF
OS Customizer zsh plugins installation can be run multiple times, once you update OS Customizer
please re-run 'zsh-plugins' installation so new plugins can be loaded.

OS Customizer zsh plugins utilize loader file at $OSC_LOADER_FILE
Please check it by 'cat $OSC_LOADER_FILE'
EOF
}


zsh-plugins_detect_dot_file() {
  if [[ -z "${SUDO_USER}" ]]; then
    # Looking current user home folder
    echo "$(realpath -e ~)/.zshrc"
  else
    echo "/home/$SUDO_USER/.zshrc"
  fi
}

zsh-plugins_install_loader() {
  local suffix;
  suffix=$(date +%Y%m%d-%H%M%S)

  echo "OS Customizer zsh plugins loader not found, installing loader..."
  echo "Backup your $1 to $1.bak-$suffix"
  cp $1 "$1.bak-$suffix"

  echo "Installing loader to $1"
  # Note $PWD will point to OS Customizer root folder
  cat>$1 <<EOF
# OS Customizer Loader, we will install small loader here and let heavy work in another file
OSC_BASE_PATH="$PWD"
if [[ -f "$OSC_LOADER_FILE" ]]; then
  source "$OSC_LOADER_FILE"
fi
# End of OS Customizer Loader, for uninstallation just remove this block

EOF

  echo "Appending $1.bak-$suffix to customized $dot_file ..."
  cat "$1.bak-$suffix" >> $1

  echo "Removing $1.bak-$suffix"
  rm "$1.bak-$suffix"

  echo "OS Customizer Loader installation done"
}

zsh-plugins_install_plugin() {
  executable=$(basename "$1" .plugin.sh)
  echo "Try to install plugin: $1 (executable: $executable)"

  if command -v $executable 2>&1 > /dev/null; then
    echo -e "source \"$1\"" >> "$OSC_LOADER_FILE"
  else
    echo "# Skip loading plugin: $1 ($executable not available)" >> "$OSC_LOADER_FILE"
  fi
}

