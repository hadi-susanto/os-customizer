export BAT_THEME="Dracula"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

batdiff() {
  git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

alias cat="bat --paging=never"

