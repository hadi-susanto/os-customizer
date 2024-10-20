# allow automatic open auto-completion
zstyle ':completion:*' menu yes select

## require eza to be installed
alias ls="eza --tree --color=always --icons=always --all --sort extension --group-directories-first"
alias ls-tree="eza --grid --color=always --icons=always --all --sort extension --group-directories-first"
alias ll="eza --long --color=always --icons=always --all --sort extension --group-directories-first --header --time-style long-iso"
alias ll-tree="eza --long --tree --color=always --icons=always --all --sort extension --group-directories-first --header --time-style long-iso"
alias ll-size="eza --long --color=always --icons=always --all --sort extension --group-directories-first --header --time-style long-iso --total-size"
alias ll-tree-size="eza --long --tree --color=always --icons=always --all --sort extension --group-directories-first --header --time-style long-iso --total-size"
alias ll-size-tree="eza --long --tree --color=always --icons=always --all --sort extension --group-directories-first --header --time-style long-iso --total-size"

## require bat to be installed
export BAT_THEME="Dracula"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
alias cat="bat --paging=never"
batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}
