# Aliases migrated from zsh.
if type -q eza
    alias ls='eza --group-directories-first'
else if type -q exa
    alias ls='exa --group-directories-first'
else
    alias ls='ls --color=auto'
end

alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'

type -q vim; and alias vi='vim'
