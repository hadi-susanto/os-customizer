#!/bin/bash

# global variable with prefix
if [[ -z "$PL10K_INSTALL_DIR" ]]; then
  # Unless defined we will assume power-level-10 cloned as our directory siblings
  PL10K_INSTALL_DIR=$(readlink -f "$PWD/../power-level-10k")
fi

if [[ -z "${SUDO_USER}" ]]; then
  # Looking current user home folder
  PL10K_DOT_ZSHRC="$(realpath -e ~)/.zshrc"
else
  PL10K_DOT_ZSHRC="/home/$SUDO_USER/.zshrc"
fi

# Short and meaningful installer description, describing the app being installed.
power-level-10k_description() {
  echo "Highly configurable zsh theme with icons, well productivity come with good Console UI"
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
power-level-10k_installed() {
  # Quite tricky to whether power level 10k installed with proper settings or not since it depend on zsh already configured
  # For now we try to lookup based on .zshrc file existence and 'powerlevel10k.zsh-theme' String
  if [[ -f "$PL10K_DOT_ZSHRC" && -n $(grep "powerlevel10k.zsh-theme" $PL10K_DOT_ZSHRC) ]]; then
    return 0
  fi

  return 1
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
power-level-10k_pre_install() {
  # Ensure zsh intalled
  if ! command -v zsh 2>&1 > /dev/null; then
    echo "power-level-10k is zsh theme, please install zsh first! when using all or recommended option, please re-run again once zsh configured."

    return 1
  fi
  # Ensure zsh configured
  if ! [[ -f "$PL10K_DOT_ZSHRC" ]]; then
    echo "zsh installed but it haven't configured yet, missing .zshrc at $PL10K_DOT_ZSHRC"

    return 1
  fi
  # No need to download resources, we already copy required resources to our repository

  return 0
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
power-level-10k_install() {
  if [[ -d "/usr/share/fonts/truetype/inconsolata" ]]; then
    echo "'/usr/share/fonts/truetype/inconsolata' found, skipping font installation"
  else
    echo "'/usr/share/fonts/truetype/inconsolata' not found or not an folder, copying font..."

    sudo mkdir /usr/share/fonts/truetype/inconsolata &&
      temp_dir=$(mktemp -d) &&
      unzip $PWD/resources/Inconsolata.zip -d $temp_dir/inconsolata &&
      sudo cp -r -v $temp_dir/inconsolata/*.ttf /usr/share/fonts/truetype/inconsolata/ &&
      fc-cache -f -v &&
      rm -r $temp_dir

    echo "Inconsolata font copied successfully"
  fi

  if [[ -d $PL10K_INSTALL_DIR ]]; then
    echo "'$PL10K_INSTALL_DIR' found, already cloned? skipping git clone"
  else
    echo "Cloning https://github.com/romkatv/powerlevel10k.git to $PL10K_INSTALL_DIR"
    git clone --depth 1 https://github.com/romkatv/powerlevel10k.git "$PL10K_INSTALL_DIR"
    echo "Cloning succeed"
  fi

  theme="$PL10K_INSTALL_DIR/powerlevel10k.zsh-theme"
  if ! [[ -f $theme ]]; then
    echo "Corrupt power level 10k repository! '$theme' was not found nor file"

    return 1
  fi

  if [[ -n $(grep "powerlevel10k.zsh-theme" $PL10K_DOT_ZSHRC) ]]; then
    echo "'source $theme' found in '$PL10K_DOT_ZSHRC', didn't touching .zshrc"
  else
    echo "Add 'source $theme' to '$PL10K_DOT_ZSHRC'"
    cat>>$PL10K_DOT_ZSHRC <<EOF

# Added by OS Customizer power-level-10k.sh installer script script
source $theme
EOF
  fi

  return 0
}

# Called after installation completed successfully
# Post installation may contains user interactive session
power-level-10k_post_install() {
  return 0
}

# Optional function / method
# Called after all installers successfuly installed. Used to inform user action once activity done.
power-level-10k_post_install_message() {
  cat <<EOF
You may need to re-launch your terminal to trigger power-level-10k configuration wizard.
If the wizard wasn't triggered, then you can force by calling 'p10k configure'
EOF
}

