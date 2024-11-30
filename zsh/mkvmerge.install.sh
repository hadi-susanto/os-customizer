mkvmerge_plugin_install() {
  if [[ -z "$MKVMERGE_DEFAULT_OUTPUT_DIR" ]]; then
    # Unless defined we will assume tlp-ui cloned as our directory siblings
    MKVMERGE_DEFAULT_OUTPUT_DIR=output
  fi

  echo "# mkvmerge.install.sh installer injecting env" >> $1
  echo -e "export MKVMERGE_DEFAULT_OUTPUT_DIR=\"$MKVMERGE_DEFAULT_OUTPUT_DIR\"" >> $1
}
