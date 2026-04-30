# dotfiles

Minimal `stow`-managed dotfiles repo.

## Packages

Current packages:

- `bash`
- `dircolors`
- `fish`
- `git`
- `inputrc`
- `ssh`
- `starship`
- `tmux`
- `vim`
- `zsh`

## Required Software

Minimum required to deploy the repo:

- `git`
- `stow`

Core tools expected by the current configs:

- `bash`
- `dircolors` (provided by `coreutils` on macOS/Homebrew)
- `fish`
- `zsh`
- `tmux`
- `vim`
- `fzf`
- `ripgrep`
- `ripgrep-all`
- `fd`
- `bat`
- `openssh-client`

Optional but recommended:

- `bash-completion`
- `cloudflared` (required when connecting to `git-ssh.linu.me`)
- `coreutils` (needed on macOS if you want `dircolors`)
- `direnv`
- `fnm`
- `fisher`
- `git-delta`
- `eza` or `exa`
- `dust`
- `bottom` / `btm`
- `btop`
- `yazi`
- `lazygit`
- `tealdeer` / `tldr`
- `jaq` (used as `jq` in interactive shells when installed)
- `yq`
- `jless`
- `fx`
- `dasel`
- `gron`
- `moreutils` / `sponge`
- `ouch`
- `doggo` / `dog`
- `bandwhich`
- `tcping`
- `visidata`
- `duckdb`
- `jujutsu` / `jj`
- `sd`
- `just`
- `starship` (if you want the shared prompt package)
- `zoxide`

See [TOOLS.md](TOOLS.md) or [TOOLS.zh-CN.md](TOOLS.zh-CN.md) for a short explanation of what each non-default tool does.

`atuin` and `mise` are documented but intentionally not installed or enabled by default: Atuin changes shell history behavior, and Mise changes per-project runtime resolution. Install and hook them manually only when you want those behaviors.

Package manifests are kept in repo so a new machine can be bootstrapped without copying commands from this README:

- `Brewfile` for macOS/Homebrew via `brew bundle --file Brewfile`
- `apt-packages.txt` for Debian/Ubuntu via `apt-get`
- `bootstrap.sh` for package install, `stow`, and Fish plugin restore

Debian/Ubuntu example:

```bash
sudo apt-get update
sudo apt-get install -y $(grep -vE '^(#|$)' apt-packages.txt)
```

Some Debian/Ubuntu releases may not provide every optional package in `apt-packages.txt`; `bootstrap.sh` falls back to installing packages one by one and skips unavailable optional packages.

macOS/Homebrew example:

```bash
brew bundle --file Brewfile
```

`fzf` does not need extra manual shell setup as long as it is installed in a standard Debian or Homebrew location. `zsh/.zshrc` auto-detects the common `fzf` completion and key-binding script paths and loads them automatically.

## Sync To A New Machine

1. Install the required software.
2. Clone the repo into `~/dotfiles`.
3. Create or update machine-local files such as `~/.gitconfig.local` and `~/.ssh/config.local`.
4. Apply the symlinks with `stow`.
5. Restart your shell, then reload `tmux` if needed.

```bash
git clone <your-dotfiles-repo> ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
exec fish
tmux source-file ~/.tmux.conf 2>/dev/null || true
```

If packages are already installed and you only want to relink configs:

```bash
./bootstrap.sh --no-install
```

If you want `zsh` to be the default login shell on a new machine:

```bash
chsh -s "$(command -v zsh)"
```

## Local Files

Current local conventions:

- portable defaults live in repo-managed files
- machine-specific overrides stay in untracked files such as `~/.tmux.conf.local`
- host-specific SSH entries stay in `~/.ssh/config.local`
- Git identity stays in `~/.gitconfig.local`
- proxy settings and internal service aliases stay in local shell override files

Recommended local files:

- `~/.gitconfig.local`
- `~/.ssh/config.local`
- `~/.tmux.conf.local`
- `~/.vimrc.local`
- `~/.zshrc.local`
- `~/.config/fish/local.fish`
- `~/.inputrc.local`
- `~/.bashrc.local`
- `~/.profile.local`

The `examples/` directory contains starter templates for the local override files used by this repo.

## Stow Basics

Apply all packages:

```bash
cd ~/dotfiles
stow bash dircolors fish git inputrc ssh starship tmux vim zsh
```

Dry-run a package without modifying anything:

```bash
cd ~/dotfiles
stow -n -v inputrc
```

Restow a package after changing its layout:

```bash
cd ~/dotfiles
stow -R starship zsh
```

Remove a package's symlinks:

```bash
cd ~/dotfiles
stow -D tmux
```
