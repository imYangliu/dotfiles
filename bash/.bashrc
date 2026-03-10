# Common bash defaults for interactive development shells.

[[ $- != *i* ]] && return

HISTCONTROL=ignoreboth:erasedups
HISTSIZE=50000
HISTFILESIZE=100000
HISTTIMEFORMAT='%F %T '

shopt -s histappend cmdhist checkwinsize extglob globstar autocd
PROMPT_COMMAND='history -a; history -n'

set -o vi

if [[ -r "$HOME/.dircolors" ]] && command -v dircolors >/dev/null 2>&1; then
  eval "$(dircolors -b "$HOME/.dircolors")"
elif command -v dircolors >/dev/null 2>&1; then
  eval "$(dircolors -b)"
fi

if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first'
elif command -v exa >/dev/null 2>&1; then
  alias ls='exa --group-directories-first'
else
  alias ls='ls --color=auto'
fi
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'

PS1='\[\033[01;36m\]\u@\h\[\033[00m\]:\[\033[01;32m\]\w\[\033[00m\]\$ '
PROMPT_DIRTRIM=3

if [[ -r "$HOME/.bash_aliases" ]]; then
  . "$HOME/.bash_aliases"
fi

if [[ -r /usr/share/bash-completion/bash_completion ]]; then
  . /usr/share/bash-completion/bash_completion
elif [[ -r /etc/bash_completion ]]; then
  . /etc/bash_completion
fi

if [[ -r "$HOME/.local/bin/env" ]]; then
  . "$HOME/.local/bin/env"
fi

if [[ -r "$HOME/.bashrc.local" ]]; then
  . "$HOME/.bashrc.local"
fi
