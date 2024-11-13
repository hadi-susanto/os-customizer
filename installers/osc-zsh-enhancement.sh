#!/bin/bash

if [[ -z "${SUDO_USER}" ]]; then
  # Looking current user home folder
  OSC_DOT_ZSHRC="$(realpath -e ~)/.zshrc"
else
  OSC_DOT_ZSHRC="/home/$SUDO_USER/.zshrc"
fi

# Short and meaningful installer description, describing the app being installed.
osc-zsh-enhancement_description() {
  cat <<EOF
This is another ZSH theme or maybe a plugin for your ZSH,
this plugin will be very biased because it created based on my workflow.
It add some shortcut and aliases to most common used apps such as git,eza, bat.
The plugin also can be found in current repository, this may copied the zsh/install.sh
EOF
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
osc-zsh-enhancement_installed() {
  # Similar to power-level-10k detection is quite a hassle
  if [[ -f "$OSC_DOT_ZSHRC" && -n $(grep "OS_CUSTOMIZER_BASE_PATH=" $OSC_DOT_ZSHRC) ]]; then
    return 0
  fi

  return 1
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
osc-zsh-enhancement_pre_install() {
    # Ensure zsh intalled
  if ! command -v zsh 2>&1 > /dev/null; then
    echo "OS Customizer Enhancement is zsh theme, please install zsh first! when using all or recommended option, please re-run again once zsh configured."

    return 1
  fi
  # Ensure zsh configured
  if ! [[ -f "$OSC_DOT_ZSHRC" ]]; then
    echo "zsh installed but it haven't configured yet, missing .zshrc at $OSC_DOT_ZSHRC"

    return 1
  fi

  # No need to download resources, we already copy required resources to our repository
  return 0
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
osc-zsh-enhancement_install() {
  # Enable auto yes for user prompt because we run in unattended mode
  OSC_AUTO_YES="true"

  # Leverage install to dedicated script, osc-zsh-enhancement used for automatic installation
  source "zsh/install.sh"
  return 0
}

# Called after installation completed successfully
# Post installation may contains user interactive session
osc-zsh-enhancement_post_install() {
  return 0
}

