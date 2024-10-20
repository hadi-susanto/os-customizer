# allow automatic open auto-completion
zstyle ':completion:*' menu yes select

# aliases
alias ls="eza --tree --color=always --icons=always --all --sort extension --group-directories-first"
alias ls-tree="eza --grid --color=always --icons=always --all --sort extension --group-directories-first"
alias ll="eza --long --color=always --icons=always --all --sort extension --group-directories-first --header --time-style long-iso"
alias ll-tree="eza --long --tree --color=always --icons=always --all --sort extension --group-directories-first --header --time-style long-iso"
alias ll-size="eza --long --color=always --icons=always --all --sort extension --group-directories-first --header --time-style long-iso --total-size"
alias tree

