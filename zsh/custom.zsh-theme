# enable Ctrl + S for forward search (https://stackoverflow.com/questions/791765/unable-to-forward-search-bash-history-similarly-as-with-ctrl-r)
stty -ixon
# allow automatic open auto-completion (https://stackoverflow.com/questions/66507024/how-to-enable-tab-completion-arrow-keys-selection-for-the-kill-command-in-zsh)
zstyle ':completion:*' menu select

if ! [[ -v PLUGINS ]]
then
  # Don't load any plugins unless defined
  PLUGINS=()
fi

for plugin in ${PLUGINS[@]}
do
  if command -v $plugin 2>&1 > /dev/null
  then
    source "$OS_CUSTOMIZER_BASE_PATH/zsh/$plugin.zsh-theme"
  else
    echo "Skip loading plugin: $plugin (required executable not available)"
  fi
done
