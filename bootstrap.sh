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

# Download the latest GitHub release asset matching a pattern and install the named binary.
_gh_install() {
  local cmd="$1" repo="$2" asset_pat="$3" bin_name="${4:-$1}"
  if command -v "$cmd" >/dev/null 2>&1; then
    printf 'already installed: %s\n' "$cmd"
    return 0
  fi
  log "Installing $cmd"
  local url
  url=$(curl -fsSL "https://api.github.com/repos/$repo/releases/latest" \
    | grep '"browser_download_url"' | grep -E "$asset_pat" | head -1 | cut -d'"' -f4)
  if [ -z "$url" ]; then
    warn "Could not find release asset for $cmd ($repo)"
    return 1
  fi
  local tmp; tmp=$(mktemp -d)
  curl -fsSL "$url" -o "$tmp/dl"
  case "$url" in
    *.tar.gz|*.tgz) tar xzf "$tmp/dl" -C "$tmp" ;;
    *.zip)          unzip -q "$tmp/dl" -d "$tmp" ;;
  esac
  local found; found=$(find "$tmp" -name "$bin_name" -type f | head -1)
  [ -z "$found" ] && found="$tmp/dl"
  mkdir -p "$HOME/.local/bin"
  cp "$found" "$HOME/.local/bin/$cmd"
  chmod +x "$HOME/.local/bin/$cmd"
  rm -rf "$tmp"
}

install_linux_extras() {
  mkdir -p "$HOME/.local/bin"

  # fnm — official install script
  if ! command -v fnm >/dev/null 2>&1; then
    log "Installing fnm"
    curl -fsSL https://fnm.vercel.app/install \
      | bash -s -- --install-dir "$HOME/.local/bin" --skip-shell
  fi

  # fx — via npm
  if ! command -v fx >/dev/null 2>&1 && command -v npm >/dev/null 2>&1; then
    log "Installing fx"
    npm install -g fx --silent
  fi

  # GitHub release binaries
  _gh_install ouch      ouch-org/ouch                'x86_64-unknown-linux-musl\.tar\.gz'
  _gh_install jaq       01mf02/jaq                   'jaq-x86_64-unknown-linux-musl"'
  _gh_install jless     PaulJuliusMartinez/jless      'x86_64.*linux.*\.zip'
  _gh_install btm       ClementTsang/bottom           'x86_64-unknown-linux-musl\.tar\.gz'   btm
  _gh_install yazi      sxyazi/yazi                   'yazi-x86_64-unknown-linux-musl\.zip'  yazi
  _gh_install duckdb    duckdb/duckdb                 'duckdb_cli-linux-amd64\.zip'           duckdb
  _gh_install jj        jj-vcs/jj                    'x86_64-unknown-linux-musl\.tar\.gz'   jj
  _gh_install doggo     mr-karan/doggo                'linux_amd64\.tar\.gz'
  _gh_install bandwhich imsnif/bandwhich              'x86_64-unknown-linux-musl\.tar\.gz'
}

install_packages() {
  case "$(uname -s)" in
    Darwin)
      install_macos
      ;;
    Linux)
      install_apt
      install_linux_extras
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
  if ! command -v fish >/dev/null 2>&1; then
    warn "fish not found; skipping Fish plugin restore"
    return 0
  fi

  if ! fish -lc 'type -q fisher' >/dev/null 2>&1; then
    log "Installing fisher"
    fish -lc 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
  fi

  log "Restoring Fish plugins with fisher"
  fish -lc 'fisher update'
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
