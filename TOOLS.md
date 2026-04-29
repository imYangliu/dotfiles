# Tool Notes

This repo expects a few command-line tools that may not be installed by default on a new machine.

| Tool | Why it is used |
| --- | --- |
| `dircolors` | Provides GNU `LS_COLORS`; on macOS it comes from Homebrew `coreutils`. |
| `fzf` | Interactive fuzzy finder used for shell history, directory jumping, git status/log pickers, and file selection. |
| `ripgrep` / `rg` | Fast recursive text search used as a modern replacement for many `grep -R` workflows. |
| `fd` | Fast, user-friendly file finder used as a modern replacement for many `find` workflows. |
| `bat` | Syntax-highlighted file viewer used as a nicer `cat`/pager companion. |
| `bash-completion` | Adds programmable completions for Bash on systems where Bash is still used. |
| `cloudflared` | Provides the SSH proxy command needed to connect to `git-ssh.linu.me`. |
| `coreutils` | Installs GNU utilities on macOS, including `dircolors`/`gdircolors`. |
| `direnv` | Loads per-project environment variables from `.envrc` when entering a directory. |
| `fnm` | Fast Node.js version manager with good Fish shell integration. |
| `fisher` | Fish plugin manager; used here to install and restore Fish plugins from `fish_plugins`. |
| `git-delta` / `delta` | Pretty pager for `git diff`, `git show`, and interactive diffs. |
| `eza` / `exa` | Modern `ls` replacement with better defaults and directory grouping. |
| `starship` | Cross-shell prompt used by both Zsh and Fish configs. |
| `zoxide` | Smarter `cd` command that learns frequently used directories. |
