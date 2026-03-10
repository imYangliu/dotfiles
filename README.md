# dotfiles

Minimal `stow`-managed dotfiles repo.

## Packages

Current packages:

- `bash`
- `git`
- `inputrc`
- `ssh`
- `tmux`
- `vim`
- `zsh`

## Required Software

Minimum required to deploy the repo:

- `git`
- `stow`

Core tools expected by the current configs:

- `bash`
- `zsh`
- `tmux`
- `vim`
- `fzf`
- `ripgrep`
- `openssh-client`

Optional but recommended:

- `bash-completion`
- `eza` or `exa`
- `zoxide`

Debian/Ubuntu example:

```bash
sudo apt-get update
sudo apt-get install -y git stow bash bash-completion zsh tmux vim fzf ripgrep openssh-client
```

macOS/Homebrew example:

```bash
brew install git stow bash zsh tmux vim fzf ripgrep openssh
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
stow bash git inputrc ssh tmux vim zsh
exec zsh
tmux source-file ~/.tmux.conf 2>/dev/null || true
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
- `~/.inputrc.local`
- `~/.bashrc.local`
- `~/.profile.local`

The `examples/` directory contains starter templates for the local override files used by this repo.

## Stow Basics

Apply all packages:

```bash
cd ~/dotfiles
stow bash git inputrc ssh tmux vim zsh
```

Dry-run a package without modifying anything:

```bash
cd ~/dotfiles
stow -n -v inputrc
```

Restow a package after changing its layout:

```bash
cd ~/dotfiles
stow -R zsh
```

Remove a package's symlinks:

```bash
cd ~/dotfiles
stow -D tmux
```

## Next

Next packages to add later:

- `dircolors`
