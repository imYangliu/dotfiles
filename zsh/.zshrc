# Common zsh defaults for terminal-heavy development.

# Keep existing PATH and local environment bootstrapping.
if [[ -r "$HOME/.local/bin/env" ]]; then
  . "$HOME/.local/bin/env"
fi

# History.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY

# Shell behavior.
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
setopt COMPLETE_IN_WORD

# Completion.
autoload -Uz compinit
mkdir -p "$HOME/.cache/zsh"
compinit -d "$HOME/.cache/zsh/zcompdump-${ZSH_VERSION}"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# fzf completion and key bindings.
function _source_first_readable() {
  typeset _candidate
  for _candidate in "$@"; do
    [[ -r "$_candidate" ]] || continue
    . "$_candidate" 2>/dev/null
    return 0
  done
  return 1
}

if (( $+commands[fzf] )); then
  export FZF_TMUX=1
  export FZF_TMUX_HEIGHT=40%
  export FZF_CTRL_T_OPTS='--walker-skip .git,node_modules,.venv,venv,dist,build,target'
  export FZF_ALT_C_OPTS='--walker-skip .git,node_modules,.venv,venv,dist,build,target'

  _source_first_readable \
    /usr/share/doc/fzf/examples/completion.zsh \
    /usr/share/fzf/completion.zsh \
    /opt/homebrew/opt/fzf/shell/completion.zsh \
    /usr/local/opt/fzf/shell/completion.zsh

  _source_first_readable \
    /usr/share/doc/fzf/examples/key-bindings.zsh \
    /usr/share/fzf/key-bindings.zsh \
    /opt/homebrew/opt/fzf/shell/key-bindings.zsh \
    /usr/local/opt/fzf/shell/key-bindings.zsh
fi
unfunction _source_first_readable

# Vim-style editing in the shell.
bindkey -v
KEYTIMEOUT=1
if (( $+commands[fzf] )); then
  bindkey -M emacs '^G' fzf-cd-widget
  bindkey -M vicmd '^G' fzf-cd-widget
  bindkey -M viins '^G' fzf-cd-widget
fi

# Cursor shape follows zsh vi mode.
function _zsh_emit_cursor_style() {
  [[ -o interactive ]] || return 0
  [[ -t 1 ]] || return 0
  [[ "$TERM" == dumb ]] && return 0

  local seq
  case "$1" in
    block) seq=$'\e[2 q' ;;        # steady block
    block-blink) seq=$'\e[1 q' ;;  # blinking block
    *) return 0 ;;
  esac

  if [[ -n "$TMUX" ]]; then
    printf '\ePtmux;\e%s\e\\' "$seq"
  elif [[ "$TERM" == screen* ]]; then
    printf '\eP%s\e\\' "$seq"
  else
    printf '%s' "$seq"
  fi
}

function _zsh_update_cursor_style() {
  case "${1:-$KEYMAP}" in
    vicmd) _zsh_emit_cursor_style block ;;
    *) _zsh_emit_cursor_style block-blink ;;
  esac
}

function zle-keymap-select {
  _zsh_update_cursor_style "$KEYMAP"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-init {
  _zsh_update_cursor_style viins
}
zle -N zle-line-init

function zle-line-finish {
  _zsh_emit_cursor_style block-blink
}
zle -N zle-line-finish

function TRAPEXIT() {
  _zsh_emit_cursor_style block-blink
}

# Prompt.
autoload -Uz colors vcs_info
colors
setopt PROMPT_SUBST
zstyle ':vcs_info:git:*' formats ' %F{yellow}[%b]%f'
if [[ ${precmd_functions[(r)vcs_info]} != vcs_info ]]; then
  precmd_functions+=(vcs_info)
fi
PROMPT='%F{cyan}%n@%m%f:%F{green}%~%f${vcs_info_msg_0_} %# '

# Search and tooling quality of life.
if [[ -r "$HOME/.dircolors" ]] && (( $+commands[dircolors] )); then
  eval "$(dircolors -b "$HOME/.dircolors")"
elif (( $+commands[dircolors] )); then
  eval "$(dircolors -b)"
fi

if (( $+commands[eza] )); then
  alias ls='eza --group-directories-first'
elif (( $+commands[exa] )); then
  alias ls='exa --group-directories-first'
else
  alias ls='ls --color=auto'
fi
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'

if (( $+commands[vim] )); then
  alias vi='vim'
fi

if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

# Load local overrides when present.
if [[ -r "$HOME/.zshrc.local" ]]; then
  . "$HOME/.zshrc.local"
fi
