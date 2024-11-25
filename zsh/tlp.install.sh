_tlp_install() {
  if ! command -v python3 2>&1 > /dev/null; then
    echo "Python 3.x not found, unable to install TLPUI plugin"

    return 0
  fi

  # This one SHOULD be sync'ed with ../installers/tlp.sh
  if [[ -z "$TLP_UI_INSTALL_DIR" ]]; then
    # Unless defined we will assume tlp-ui cloned as our directory siblings
    TLP_UI_INSTALL_DIR=$(readlink -f "$PWD/..")/tlp-ui
  fi

  echo "# tlp.install.sh installer injecting env" >> $1
  echo -e "export TLP_UI_PYTHONPATH=\"$TLP_UI_INSTALL_DIR\"" >> $1
}
