#!/bin/bash

# Detect whether we run with root privilege or not, installers script may need to run with root privilege
if [[ "$EUID" -ne 0 ]]; then
  echo "WARNING: running on non root privilege !"
  echo "OS Customizer Package Installer itself didn't require root privilege,"
  echo "but individual installer may require root privilege for execution."
  echo # Intentional blank line
  echo "Depending on installer script you may be asked for root password while installing."
  echo "To prevent entering root password while installing please re-run with 'sudo $0'"
  echo -n "Press Enter to continue or Ctrl + C to abort."
  read -r
  echo # Intentional blank line
fi

# Define the installers path
directory="installers"

# Initialize an empty array to store .sh file names without extension
file_names=()

# Loop through all .sh files in the directory
for file in "$directory"/*.sh; do
  # Check if it is a file (not a directory) and ensure the file exists
  if ! [[ -f "$file" ]]; then
    continue
  fi

  # Remove the directory path and file extension
  file_name=$(basename "$file" .sh)

  # Skip template
  if [[ "$file_name" == "template" ]]; then
    continue
  fi

  # Add the file name (without extension) to the array
  file_names+=("$file_name")
done

# Check if the array is empty
if [ ${#file_names[@]} -eq 0 ]; then
  echo "No .sh installers found in the '$directory' directory."
  exit 1
fi

# Initialize an empty array to store valid user choices
user_choices=()

# Loop to prompt the user for input
while true; do
  # Clear the screen
  clear

  # Display OS Customizer header
  echo "------------------------------------------------"
  echo " OS Customizer Package Installer"
  echo "------------------------------------------------"
  
  # Print available installers
  index=1
  echo "Available installer(s):"
  for name in "${file_names[@]}"; do
    echo "$index. $name"
    ((index++))
  done
  echo # Blank line after the list

  # Print a list of already selected installers
  if [ ${#user_choices[@]} -gt 0 ]; then
    echo "Already selected installers:"
    for choice in "${user_choices[@]}"; do
      echo "- ${file_names[choice-1]}"
    done
    echo # Blank line after the list
  fi

  # Prompt for user input
  echo -n "Please enter [1-${#file_names[@]}/(a)ll/(q)uit]: "
  read -r user_input
  
  # Break the loop if the user enters 'q' or 'quit'
  if [[ "$user_input" == "q" || "$user_input" == "quit" ]]; then
    break
  fi

  # Add all installers if the user enters 'all' and then break
  if [[ "$user_input" == "a" || "$user_input" == "all" ]]; then
    for ((i=1; i<=${#file_names[@]}; i++)); do
      user_choices+=("$i")
    done
    break
  fi
  
  # If user presses Enter without input, continue the loop
  if [[ -z "$user_input" ]]; then
    continue
  fi

  # Validate user input is a number within the valid range
  if ! [[ "$user_input" =~ ^[0-9]+$ ]] || ((user_input < 1 || user_input > ${#file_names[@]})); then
    echo "Invalid input: Please enter a number between 1 and ${#file_names[@]}."
    echo -n "Press Enter to continue..."
    read -r
    continue
  fi

  # Check if the installer has already been selected
  if [[ " ${user_choices[@]} " =~ " $user_input " ]]; then
    echo "You have already selected this installer. Please choose a different one."
    echo -n "Press Enter to continue..."
    read -r
    continue
  fi

  # Add the validated input to the list of choices
  user_choices+=("$user_input")
done

# Guard clause: Exit if no installers were selected
if [ ${#user_choices[@]} -eq 0 ]; then
  echo "No installers selected. Exiting."
  exit 1
fi

# Confirm if the user wants to execute the selected installers
echo -e "\nYou have selected the following installers:"
for choice in "${user_choices[@]}"; do
  echo "- ${file_names[choice-1]}"
done
echo # Blank line after the list

echo -n "Do you want to execute these installers? (y/N): "
read -r confirm

# Guard clause: Exit if the user does not confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "Installation canceled."
  exit 1
fi

# Helper function to start installation
start_installation() {
  # Alias variable name for easier scripting
  name=$1

  # Installation header
  echo "----------------------------------------------------"
  echo "Begin '$name' installation"
  echo "----------------------------------------------------"

  # Load installer script
  script_path="$directory/$1.sh"
  echo -e "\nSourcing '$script_path'..."
  source "$script_path"

  # Validating sourced script
  echo "Done, begin installer validation..."
  if ! declare -F "${name}_describe" > /dev/null; then
    echo "Can't found '${name}_describe' function, installer file don't comply with OS Customizer interface, please open issue for '$script_path'"

    return 1
  fi
  if ! declare -F "${name}_pre_install" > /dev/null; then
    echo "Can't found '${name}_pre_install' function, installer file don't comply with OS Customizer interface, please open issue for '$script_path'"

    return 1
  fi
  if ! declare -F "${name}_install" > /dev/null; then
    echo "Can't found '${name}_install' function, installer file don't comply with OS Customizer interface, please open issue for '$script_path'"

    return 1
  fi
  if ! declare -F "${name}_post_install" > /dev/null; then
    echo "Can't found '${name}_post_install' function, installer file don't comply with OS Customizer interface, please open issue for '$script_path'"

    return 1
  fi

  # All required installer interface found, start installation process...
  echo -e "\nDescription:"
  ${name}_describe
  echo -e "\nExecute pre-install..."
  if ! ${name}_pre_install; then
    echo "'$installer' pre-install phase failed! please check for any error messages"

    return 1
  fi
  echo -e "\nExecute install..."
  if ! ${name}_install; then
    echo "'$installer' installation phase failed! please check for any error messages"

    return 1
  fi
  echo -e "\nExecute post-install..."
  if ! ${name}_post_install; then
    echo "'$installer' post-install phase failed, but the app itself installed successfully! please check for any error messages"

    return 1
  fi

  echo "'$installer' installation done, please enjoy."
  echo # Intentional blank line

  return 0
}

# Clear the screen before we start with installation
clear

# Store any failed installer here
failed_installers=()

# Execute selected installers
for choice in "${user_choices[@]}"; do
  installer=${file_names[choice-1]}
  if start_installation $installer; then
    continue
  fi
  
  # Installer return non success code
  # Add failed installer to list, we will print it later once all installer done
  failed_installers+=("$installer")
  # Let user to see any error messages before continuing
  echo "Fail to install $installer, please read any error messages above and report it."
  echo # Intentional blank line
done

if [ ${#failed_installers[@]} -eq 0 ]; then
  echo "All selected installers have been executed."

  exit 0
fi

# Found some failed installer, just print to users
index=1
echo "All selected installers have been executed, unfortunately some installer(s) is failed:"
for name in "${failed_installers[@]}"; do
  echo "$index. $name"
  ((index++))
done

