#!/bin/bash

# global variable with prefix
if [[ -z "$PL10K_NERD_FONT" ]]; then
  # Unless defined we will use Inconsolata
  PL10K_NERD_FONT="Inconsolata"
fi
PL10K_FONT_INSTALL_DIR="/usr/share/fonts/truetype/$PL10K_NERD_FONT"

if [[ -z "$PL10K_INSTALL_DIR" ]]; then
  # Unless defined we will assume power-level-10 cloned as our directory siblings
  PL10K_INSTALL_DIR=$(readlink -f "$PWD/..")/power-level-10k
fi

if [[ -z "${SUDO_USER}" ]]; then
  # Looking current user home folder
  PL10K_DOT_ZSHRC="$(realpath -e ~)/.zshrc"
else
  PL10K_DOT_ZSHRC="/home/$SUDO_USER/.zshrc"
fi

p10k_temp_folder=""

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

  power-level-10k_download_nerd_font
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
power-level-10k_install() {
  if [[ -n $p10k_temp_folder && -f "$p10k_temp_folder/font.zip" ]]; then
    echo "Found downloaded font, installing..."

    sudo mkdir "$PL10K_FONT_INSTALL_DIR" &&
        unzip "$p10k_temp_folder/font.zip" -d "$p10k_temp_folder/font" &&
        sudo cp -r -v $p10k_temp_folder/font/*.ttf "$PL10K_FONT_INSTALL_DIR/" &&
        fc-cache -f -v

    echo "$PL10K_NERD_FONT font copied successfully, font cache also updated"
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
}

# Called after installation completed successfully
# Post installation may contains user interactive session
power-level-10k_post_install() {
  if [[ -n $p10k_temp_folder && -d $p10k_temp_folder ]]; then
    rm -r $p10k_temp_folder
  fi
}

# Optional function / method
# Called after all installers successfuly installed. Used to inform user action once activity done.
power-level-10k_post_install_message() {
  cat <<EOF
* You may need to re-launch your terminal to trigger power-level-10k configuration wizard.
* If the wizard wasn't triggered, then you can force by calling 'p10k configure'
* Don't forget to setup Font settings to 'Inconsolota Nerd Mono Font Regular' size 11
EOF
}

power-level-10k_download_nerd_font() {
  if [[ -d $PL10K_FONT_INSTALL_DIR ]]; then
    echo "$PL10K_FONT_INSTALL_DIR folder exists, assumed font already installed, skip download"

    return 0
  fi

  echo "Generating download link for '$PL10K_NERD_FONT' nerd font from https://www.nerdfonts.com/font-downloads"
  link=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep "browser_download_url.*$PL10K_NERD_FONT\.zip" | cut -d : -f 2,3 | tr -d \")
  p10k_temp_folder=$(mktemp -d)

  echo "Downloading from: '$link' to '$p10k_temp_folder/font.zip'"
  echo $link | wget -nv --show-progress -i - -O "$p10k_temp_folder/font.zip"

  if ! [[ -f "$p10k_temp_folder/font.zip" ]]; then
    echo "Download $link fail, aborting installation"

    return 1
  fi

  echo "$link downloaded successfully..."

  return 0
}

