#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
stow_packages=(bash dircolors fish git inputrc ssh starship tmux vim zsh)

log() {
  printf '\n==> %s\n' "$*"
}

warn() {
  printf 'WARN: %s\n' "$*" >&2
}

install_macos() {
  if ! command -v brew >/dev/null 2>&1; then
    warn "Homebrew is not installed. Install it first: https://brew.sh/"
    return 1
  fi

  log "Installing Homebrew packages from Brewfile"
  brew bundle --file "$repo_dir/Brewfile"
}

apt_packages() {
  sed -e 's/#.*//' -e '/^[[:space:]]*$/d' "$repo_dir/apt-packages.txt"
}

install_apt() {
  if ! command -v apt-get >/dev/null 2>&1; then
    warn "apt-get not found; skipping apt package installation"
    return 0
  fi

  log "Updating apt package index"
  sudo apt-get update

  mapfile -t packages < <(apt_packages)
  log "Installing apt packages"
  if ! sudo apt-get install -y "${packages[@]}"; then
    warn "Bulk apt install failed; retrying packages one by one so unsupported optional packages do not block bootstrap"
    for package in "${packages[@]}"; do
      sudo apt-get install -y "$package" || warn "Skipped apt package: $package"
    done
  fi
}

install_packages() {
  case "$(uname -s)" in
    Darwin)
      install_macos
      ;;
    Linux)
      install_apt
      ;;
    *)
      warn "Unsupported OS: $(uname -s). Install packages manually, then re-run with --no-install."
      ;;
  esac
}

stow_dotfiles() {
  if ! command -v stow >/dev/null 2>&1; then
    warn "stow is not installed; cannot link dotfiles"
    return 1
  fi

  log "Stowing dotfiles"
  cd "$repo_dir"
  stow -R "${stow_packages[@]}"
}

restore_fish_plugins() {
  if command -v fish >/dev/null 2>&1; then
    if fish -lc 'type -q fisher' >/dev/null 2>&1; then
      log "Restoring Fish plugins with fisher"
      fish -lc 'fisher update'
    else
      warn "fisher not found in Fish; skipping Fish plugin restore"
    fi
  fi
}

usage() {
  cat <<'USAGE'
Usage: ./bootstrap.sh [--no-install] [--no-stow] [--no-fish-plugins]

Install packages for this dotfiles repo, stow managed configs, and restore Fish plugins.
USAGE
}

main() {
  install=1
  do_stow=1
  fish_plugins=1

  while [ "$#" -gt 0 ]; do
    case "$1" in
      --no-install) install=0 ;;
      --no-stow) do_stow=0 ;;
      --no-fish-plugins) fish_plugins=0 ;;
      -h|--help) usage; exit 0 ;;
      *) usage; exit 2 ;;
    esac
    shift
  done

  [ "$install" -eq 0 ] || install_packages
  [ "$do_stow" -eq 0 ] || stow_dotfiles
  [ "$fish_plugins" -eq 0 ] || restore_fish_plugins

  log "Done"
  printf 'Restart your shell or run: exec fish\n'
}

main "$@"
