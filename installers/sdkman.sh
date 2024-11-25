#!/bin/bash

# Global variables, we use same variable as SDKMAN script from https://get.sdkman.io/
if [[ -z "$SDKMAN_DIR" ]]; then
  # Unless defined we will assume sdkman cloned as our directory siblings
  SDKMAN_DIR=$(readlink -f "$PWD/..")/sdkman
fi

# Short and meaningful installer description, describing the app being installed.
sdkman_description() {
  echo "Mainly for Java SDK Manager"
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
sdkman_installed() {
  command -v sdk 2>&1 > /dev/null
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
sdkman_pre_install() {
  return 0
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
sdkman_install() {
  echo "Installing SDKMAN into '$SDKMAN_DIR'"

  if [[ -d $SDKMAN_DIR ]]; then
    echo "SDKMAN installation dir: $SDKMAN_DIR found, move as .bak folder and will delete after installation."
    mv $SDKMAN_DIR "$SDKMAN_DIR.bak"
  fi

  export SDKMAN_DIR=$SDKMAN_DIR && curl -s "https://get.sdkman.io" | bash
}

# Called after installation completed successfully
# Post installation may contains user interactive session
sdkman_post_install() {
  if [[ -d "$SDKMAN_DIR.bak" ]]; then
    echo "Deleting '$SDKMAN_DIR.bak' folder..."
    rm -r "$SDKMAN_DIR.bak"
  fi
}

# Optional to implements, this method called once all installation done
# Useful to print informational message to users
sdkman_post_install_message() {
  cat <<EOF
Quoting from SDKMAN installer with some changes:

Please open a new terminal, or run the following in the existing one:

    SDKMAN_DIR="$SDKMAN_DIR" source "$SDKMAN_DIR/bin/sdkman-init.sh"

Then issue the following command:

    sdk help

Enjoy!!!
EOF
}

