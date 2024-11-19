#!/bin/bash

# Define the installers path and lookup for it
directory="installers"
# Initialize an empty array to store .sh file names without extension
file_names=()
# Initialize an empty array to store valid user choices
selected_installers=()
# Recommended software / packages
recommended_installers=(apt-fast bat cryptomator dnscrypt-proxy double-commander eza flameshot insync keepass-xc power-level-10k terminator zsh zsh-plugins)
development_installers=(microsoft-edge sdkman)
# ANSI colors (https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux)
CYAN='\033[0;36m'
LIGHT_BLUE='\033[1;34m'
LIGHT_GREEN='\033[1;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to detect whether we run with root privilege or not.
# Installers script may need to run with root privilege.
detect_root_privileges() {
  if [[ "$EUID" -eq 0 ]]; then
    return 0
  fi

  cat <<EOF
WARNING: running on non root privilege ! This script doesn't need root privilege to run.
Installer may require root privilege for it's execution, you may be asked for root password
unless re-run this script with root privilege. In case you want to run with root privilege:

Ctrl + C, sudo ./run-installer.sh

EOF
}

installer_method_exists() {
  if declare -F "$2" > /dev/null; then
    return 0
  fi

  echo "Can't found '$2' function, installer file don't comply with OS Customizer interface, please open issue for '$1'"
  echo

  return 1
}

# Loop through all .sh files in the directory
populate_installers() {
  for file in "$1"/*.sh; do
    # Check if it is a file (not a directory) and ensure the file exists
    if ! [[ -f "$file" ]]; then
      continue
    fi

    # Skip template
    if [[ $file == "installers/template.sh" ]]; then
      continue
    fi

    # Try load installer
    source $file
    # Remove the directory path and file extension
    installer=$(basename "$file" .sh)
    # Validating sourced script
    required_methods=("${installer}_installed" "${installer}_description" "${installer}_pre_install" "${installer}_install" "${installer}_post_install")
    for method in "${required_methods[@]}"; do
      if ! installer_method_exists $file $method; then
        return 1
      fi
    done
    # Add the installer (without extension) to the array
    file_names+=("$installer")
  done

  # Check if the array is empty
  if [ ${#file_names[@]} -eq 0 ]; then
    echo "No .sh installers found in the '$directory' directory."
    return 1
  fi

  return 0
}

# Print list of any installers / selected installers with recommended indication
print_list() {
  index=1
  list=("$@")

  for item in "${list[@]}"; do
    printf "%4d. %-20s" $index $item
    # Detect if current installer in recommended list
    if [[ " ${recommended_installers[@]} " =~ " $item " ]]; then
      printf "${LIGHT_GREEN}%-15s${NC}" "(recommended)"
    fi
    # Detect if current installer in development list
    if [[ " ${development_installers[@]} " =~ " $item " ]]; then
      printf "${YELLOW}%-15s${NC}" "(for-dev)"
    fi
    if ("${item}_installed") then
      printf "${LIGHT_BLUE}%-15s${NC}" "(installed)"
    fi
    # Line break
    printf "\n"

    ((index++))
  done

  echo # Blank line after the list
}

# Loop to prompt the user for input
main_loop_user_input() {
  while true; do
    # Clear the screen
    clear

    # Display OS Customizer header
    echo "------------------------------------------------------------------------------"
    echo " OS Customizer Package Installer"
    echo "------------------------------------------------------------------------------"
    detect_root_privileges

    # Print available installers
    echo "Available installer(s):"
    # https://askubuntu.com/questions/674333/how-to-pass-an-array-as-function-argument
    print_list "${file_names[@]}"

    # Print a list of already selected installers
    if [ ${#selected_installers[@]} -gt 0 ]; then
      echo "Already selected installers:"
      print_list "${selected_installers[@]}"
    fi

    # Prompt for user input
    echo -n "Please enter [1-${#file_names[@]}/(r)ecommended/(a)ll/(d)one]: "
    read -r user_input
    
    # If user presses Enter without input, continue the loop
    if [[ -z "$user_input" ]]; then
      continue
    fi
    
    # Break the loop if the user enters 'd' or 'done'
    if [[ "$user_input" == "d" || "$user_input" == "done" ]]; then
      break
    fi

    # Add all installers if the user enters 'all' and then break
    if [[ "$user_input" == "a" || "$user_input" == "all" ]]; then
      selected_installers=("${file_names[@]}")
      break
    fi

    # Add all recommended installer when user enter 'r' or 'recommended' and then break
    if [[ "$user_input" == "r" || "$user_input" == "recommended" ]]; then
      selected_installers=("${recommended_installers[@]}")
      break
    fi

    # Validate user input is a number within the valid range
    if ! [[ "$user_input" =~ ^[0-9]+$ ]] || ((user_input < 1 || user_input > ${#file_names[@]})); then
      echo "Invalid input: Please enter a number between 1 and ${#file_names[@]}."
      echo -n "Press Enter to continue..."
      read -r
      continue
    fi

    # Convert user input to installer name
    selected_installer="${file_names[user_input-1]}"

    # Check if the installer has already been selected
    if [[ " ${selected_installers[@]} " =~ " $selected_installer " ]]; then
      echo "'$selected_installer' already selected, please choose a different one or enter 'd' to complete selections."
      echo -n "Press Enter to continue..."
      read -r
      continue
    fi

    # Add the validated input to the list of choices
    selected_installers+=("$selected_installer")
  done
}

# Helper function to start installation
start_installation() {
  # Alias function parameter to variable installer for easier scripting
  installer=$1

  # Installation header
  echo "------------------------------------------------------------------------------"
  echo "Begin '$installer' installation"
  echo "------------------------------------------------------------------------------"

  # Load installer script
  script_path="$directory/$1.sh"
  source "$script_path"

  # Validating sourced script
  required_methods=("${installer}_installed" "${installer}_description" "${installer}_pre_install" "${installer}_install" "${installer}_post_install")
  for method in "${required_methods[@]}"; do
    if ! installer_method_exists $script_path $method; then
      return 1
    fi
  done

  if (${installer}_installed) && ! [ "$FORCE_INSTALL" == "true" ]; then
    echo -e "\nSkipping '$installer' since it was already installed in your current machine."
    echo "To force (re-)install please export 'FORCE_INSTALL=true' environment variable."

    return 0
  fi

  # All required installer interface found, start installation process...
  echo "Description:"
  ${installer}_description
  echo -e "\nExecute pre-install..."
  if ! ${installer}_pre_install; then
    echo "'$installer' pre-install phase failed! please check for any error messages"

    return 1
  fi
  echo -e "\nExecute install..."
  if ! ${installer}_install; then
    echo "'$installer' installation phase failed! please check for any error messages"

    return 1
  fi
  echo -e "\nExecute post-install..."
  if ! ${installer}_post_install; then
    echo "'$installer' post-install phase failed, but the app itself installed successfully! please check for any error messages"

    return 1
  fi

  echo "'$installer' installation done, please enjoy."

  return 0
}

installation_loop() {
  # Track success / failed installation
  success_installers=()
  failed_installers=()

  # Execute selected installers
  for installer in "${selected_installers[@]}"; do
    if start_installation $installer; then
      success_installers+=("$installer")
      echo # Intentional blank line

      continue
    fi
    
    # Installer return non success code
    # Add failed installer to list, we will print it later once all installer done
    failed_installers+=("$installer")
    # Let user to see any error messages before continuing
    echo "Fail to install $installer, please read any error messages above and report it."
    echo # Intentional blank line
  done

  # Print any post install message if any
  echo "------------------------------------------------------------------------------"
  echo "OS Customizer Package Installer have completed installations..."
  echo "------------------------------------------------------------------------------"
  for installer in "${success_installers[@]}"; do
    if ! declare -F "${installer}_post_install_message" > /dev/null; then
      continue;
    fi

    echo "'$installer' post install message:"
    ${installer}_post_install_message
    echo # Intentional blank line
  done

  if [ ${#failed_installers[@]} -eq 0 ]; then
    echo "All selected installers have been executed."

    return 0
  fi

  # Found some failed installer, just print to users
  index=1
  echo "All selected installers have been executed, unfortunately some installer(s) is failed:"
  for installer in "${failed_installers[@]}"; do
    printf "%4d. %s\n" $index $installer
    ((index++))
  done
}

# Start main loop
if ! populate_installers $directory; then
  echo "Fail to load installer(s) please check above error messages if any..."
  exit 1
fi
main_loop_user_input

# Guard clause: Exit if no installers were selected
if [ ${#selected_installers[@]} -eq 0 ]; then
  echo "No installers selected. Exiting."
  exit 1
fi

# Confirm if the user wants to execute the selected installers
clear
echo "------------------------------------------------------------------------------"
echo " OS Customizer Package Installer - Installation Phase"
echo "------------------------------------------------------------------------------"
echo "You have selected the following installers:"
print_list "${selected_installers[@]}"

echo -n "Do you want to execute these installers? (Y/n): "
read -r confirm

# Guard clause: Exit if the user does not confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" && "$confirm" != "" ]]; then
  echo "Installation canceled."
  exit 1
fi

# Clear the screen before we start with installation
clear
installation_loop

