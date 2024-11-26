#!/bin/bash

# Global Variable(s)
if [[ -z "$APACHE_MAVEN_INSTALL_DIR" ]]; then
  # Unless defined we will assume sdkman cloned as our directory siblings
  APACHE_MAVEN_INSTALL_DIR=$(readlink -f "$PWD/..")/apache-maven
fi

maven_temp_dir=""

# Short and meaningful installer description, describing the app being installed.
apache-maven_description() {
  echo "Apache Maven (Project Management tools for Java)"
}

# Check whether app already installed or not, checking can be easily done by "command" function
# to check command existence.
apache-maven_installed() {
  if [[ -d "$APACHE_MAVEN_INSTALL_DIR" ]]; then
    return 0
  else
    return 1
  fi
}

# Called before installation phase, used to update repositories, downloading dependencies, etc.
# It's recommended to use pre-install phase to prepare installation instead at install phase
apache-maven_pre_install() {
  maven_temp_dir=$(mktemp -d)

  echo "Generating download link..."
  local link=$(curl -s https://maven.apache.org/download.cgi | grep -m 1 "apache-maven-.*-bin\.zip" | cut -d \" -f 2)

  echo "Downloading latest maven from $link"
  echo $link | wget -nv --show-progress -i - -O "$maven_temp_dir/maven.zip"
}

# Called after pre-install phase completed successfully
# Installation phase, usually via package manager installation or manual download...
apache-maven_install() {
  unzip "$maven_temp_dir/maven.zip" -d $maven_temp_dir

  local maven_folder;
  for dir in "$maven_temp_dir"/apache-maven*/; do
    if [[ -d "$dir" ]]; then
        maven_folder=$dir
        break
    fi
  done

  if [[ -z "$maven_folder" ]]; then
    echo "Unable to find folder named maven* inside $maven_temp_dir"
    echo "Aborting installation... please download maven manually from https://maven.apache.org/download.cgi"

    return 1
  fi

  local last_folder=$(basename "$maven_folder")
  local maven_version=${last_folder#apache-maven-}

  if [[ -d "$APACHE_MAVEN_INSTALL_DIR-$maven_version" ]]; then
    echo "Previous installation folder found, removing: $APACHE_MAVEN_INSTALL_DIR-$maven_version"
    rm -r "$APACHE_MAVEN_INSTALL_DIR-$maven_version"
  fi

  if [[ -L "$APACHE_MAVEN_INSTALL_DIR" ]]; then
    echo "Maven symbolic link found, removing: $APACHE_MAVEN_INSTALL_DIR"
    rm "$APACHE_MAVEN_INSTALL_DIR"
  fi

  mkdir "$APACHE_MAVEN_INSTALL_DIR-$maven_version" &&
    cp -r -v "$maven_folder"/* "$APACHE_MAVEN_INSTALL_DIR-$maven_version" &&
    ln -s -d "$APACHE_MAVEN_INSTALL_DIR-$maven_version" "$APACHE_MAVEN_INSTALL_DIR"
}

# Called after installation completed successfully
# Post installation may contains user interactive session
apache-maven_post_install() {
  rm -r $maven_temp_dir

  # Do nothing don't touch PATH env variable
  if command -v apt-fast 2>&1 > /dev/null; then
    return 0
  fi

  echo "mvn isn't found in current shell PATH, installing maven binary into ~/.profile"
  echo >> ~/.profile
  echo "# OS Customizer script, add apache maven binaries to environment variable" >> ~/.profile
  echo "PATH=$APACHE_MAVEN_INSTALL_DIR/bin:$PATH" >> ~/.profile
}

# Optional to implements, this method called once all installation done
# Useful to print informational message to users
apache-maven_post_install_message() {
  cat <<EOF
RECOMMENDED:
 - Move apache maven cache directory from ~/.m2 to dedicated folder, it WILL TAKE LOTS SPACE
    Change it by editing $APACHE_MAVEN_INSTALL_DIR/conf/settings.xml
    Look for '<localRepository>' element, un-comment and prepare new cache folder

WARNING: 
 * maven binaries should be added into PATH variable, verify it by calling mvn
 * If calling mvn fail, please relogin since .profile only executed at login
 * $APACHE_MAVEN_INSTALL_DIR is a symbolic link to $(readlink -f "$APACHE_MAVEN_INSTALL_DIR")
 * Symbolic link used for easy rollback mechanism
EOF
}

