# Login shell bootstrap for sh/bash.

if [ -n "$BASH_VERSION" ] && [ -r "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi

if [ -r "$HOME/.local/bin/env" ]; then
  . "$HOME/.local/bin/env"
fi

# Homebrew environment for Bash/login shells.
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export EDITOR=vim
export VISUAL=vim

if [ -r "$HOME/.profile.local" ]; then
  . "$HOME/.profile.local"
fi
