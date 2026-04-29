# Tool Notes

This repo expects a few command-line tools that may not be installed by default on a new machine. The table below explains what each tool does, how this dotfiles repo wires it in, and a few common commands to try.

| Tool | Why it is used | Config, aliases, and common usage |
| --- | --- | --- |
| `dircolors` | Provides GNU `LS_COLORS`; on macOS it comes from Homebrew `coreutils`. | Used by shell configs when `~/.dircolors` exists. Common usage: `dircolors -b ~/.dircolors` prints shell code for colorized GNU `ls`. |
| `fzf` | Interactive fuzzy finder used for shell history, directory jumping, git status/log pickers, and file selection. | Fish uses `patrickf1/fzf.fish`. Key bindings: `Ctrl-R` history, `Ctrl-G` directories, `Ctrl-S` git status, `Ctrl-L` git log, `Ctrl-P` processes, `Ctrl-V` variables. Common usage: `fzf`, `git branch \| fzf`. |
| `ripgrep` / `rg` | Fast recursive text search used as a modern replacement for many `grep -R` workflows. | No alias; use directly. Common usage: `rg pattern`, `rg -n "TODO" src`, `rg --files`, `rg -i pattern`. |
| `fd` | Fast, user-friendly file finder used as a modern replacement for many `find` workflows. | Fish alias: `f='fd'`. Common usage: `fd name`, `fd -e ts`, `fd config ~/.config`, `fd -H pattern` to include hidden files. |
| `bat` | Syntax-highlighted file viewer used as a nicer `cat`/pager companion. | Fish alias: `c='bat'`. Common usage: `bat file`, `bat -n file`, `bat --paging=never file`, `bat -p file` for plain output. |
| `bash-completion` | Adds programmable completions for Bash on systems where Bash is still used. | No Fish alias. Common usage: install it when you still use Bash configs; Bash will source completion scripts from standard locations. |
| `cloudflared` | Provides the SSH proxy command needed to connect to `git-ssh.linu.me`. | Used by `ssh/.ssh/config` for the internal Git SSH host. Common usage: normal `git fetch`/`git push` to `git-ssh.linu.me`; `cloudflared` runs behind the SSH config. |
| `coreutils` | Installs GNU utilities on macOS, including `dircolors`/`gdircolors`. | No alias in this repo. Common usage on macOS: GNU tools are usually prefixed with `g`, such as `gdate`, `gsed`, and `gdircolors`. |
| `direnv` | Loads per-project environment variables from `.envrc` when entering a directory. | Fish config runs `direnv hook fish \| source`. Common usage: create `.envrc`, run `direnv allow`, then `direnv status` or `direnv reload`. |
| `fnm` | Fast Node.js version manager with good Fish shell integration. | Fish config runs `fnm env --use-on-cd --shell fish \| source`. Common usage: `fnm install --lts`, `fnm use 22`, `fnm default 22`, `fnm current`, `fnm list`. |
| `fisher` | Fish plugin manager; used here to install and restore Fish plugins from `fish_plugins`. | Current plugin list lives in `fish/.config/fish/fish_plugins`. Common usage: `fisher install owner/repo`, `fisher remove owner/repo`, `fisher update`. |
| `git-delta` / `delta` | Pretty pager for `git diff`, `git show`, and interactive diffs. | Git config sets `core.pager=delta` and `interactive.diffFilter=delta --color-only`. Common usage: `git diff`, `git show`, `git log -p`; run `delta --help` for themes/options. |
| `eza` / `exa` | Modern `ls` replacement with better defaults and directory grouping. | Fish aliases `ls` to `eza --group-directories-first` when available, otherwise `exa`, otherwise macOS `ls -G`. Related aliases: `ll='ls -lah'`, `la='ls -A'`, `l='ls -CF'`. |
| `starship` | Cross-shell prompt used by both Zsh and Fish configs. | Config lives at `starship/.config/starship.toml`. Common usage: `starship explain`, `starship timings`, `starship print-config`. |
| `zoxide` | Smarter `cd` command that learns frequently used directories. | Fish config runs `zoxide init fish \| source`, which provides `z` and `zi`. Common usage: `z repo`, `z dotfiles`, `zi` for interactive directory selection, `zoxide query name`. |

## Git Abbreviations

Fish abbreviations expand when accepted, so command history keeps the full command instead of the short name.

| Abbr | Expands to | Use case |
| --- | --- | --- |
| `gst` | `git status -sb` | Compact repository status with branch info. |
| `ga` | `git add` | Stage files. |
| `gc` | `git commit` | Create a commit. |
| `gcm` | `git commit -m` | Commit with an inline message. |
| `gp` | `git push` | Push current branch. |
| `gl` | `git pull` | Pull from upstream. |
| `gco` | `git checkout` | Checkout branch/path; kept for older Git workflows. |
| `gsw` | `git switch` | Switch branches. |
| `gd` | `git diff` | Show unstaged diff through `delta`. |
| `lg` | `git log --graph ...` | Compact decorated commit graph. |
