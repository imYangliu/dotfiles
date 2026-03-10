# Login shell bootstrap for sh/bash.

if [ -n "$BASH_VERSION" ] && [ -r "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi

if [ -r "$HOME/.local/bin/env" ]; then
  . "$HOME/.local/bin/env"
fi

export EDITOR=vim
export VISUAL=vim

if [ -r "$HOME/.profile.local" ]; then
  . "$HOME/.profile.local"
fi
