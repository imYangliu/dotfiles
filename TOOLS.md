# Tool Notes

This repo expects a few command-line tools that may not be installed by default on a new machine. The table below explains what each tool does, how this dotfiles repo wires it in, and a few common commands to try.

| Tool | Why it is used | Config, aliases, and common usage |
| --- | --- | --- |
| `dircolors` | Provides GNU `LS_COLORS`; on macOS it comes from Homebrew `coreutils`. | Used by shell configs when `~/.dircolors` exists. Common usage: `dircolors -b ~/.dircolors` prints shell code for colorized GNU `ls`. |
| `fzf` | Interactive fuzzy finder used for shell history, directory jumping, git status/log pickers, and file selection. | Fish uses `patrickf1/fzf.fish`. Key bindings: `Ctrl-R` history, `Ctrl-G` directories, `Ctrl-S` git status, `Ctrl-L` git log, `Ctrl-P` processes, `Ctrl-V` variables. Common usage: `fzf`, `git branch \| fzf`. |
| `ripgrep` / `rg` | Fast recursive text search used as a modern replacement for many `grep -R` workflows. | No alias; use directly. Common usage: `rg pattern`, `rg -n "TODO" src`, `rg --files`, `rg -i pattern`. |
| `ripgrep-all` / `rga` | Wrapper around ripgrep for searching rich file types such as PDFs, Office documents, ebooks, archives, SQLite databases, and media metadata. | No alias; use `rg` for code and `rga` for documents/binary-rich files. Common usage: `rga keyword ~/Documents`, `rga -i invoice .`. |
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
| `dust` | Visual disk-usage viewer used as a clearer replacement for many `du` workflows. | Fish alias: `dsize='dust'`. Common usage: `dust`, `dust -d 2`, `dust ~/Downloads`. |
| `bottom` / `btm` | Terminal system monitor with detailed CPU, memory, disk, network, temperature, and process panels. | Fish alias: `sysmon='btm'`. Common usage: `btm`, `btm --basic`, `btm --battery`. |
| `btop` | Polished interactive process and resource monitor; a nicer daily replacement for `top`/`htop`. | Fish alias: `topplus='btop'`. Common usage: `btop`; use it when you want a quick visual process/resource overview. |
| `yazi` | Terminal file manager with fast navigation and previews. | Fish alias: `yy='yazi'`; Fish function `y` opens Yazi and changes the shell to Yazi's last directory on exit. Common usage: `y`, `yy`, `y path/to/dir`. |
| `lazygit` | Terminal UI for Git status, staging, commits, branches, stash, and logs. | No alias; use directly. Common usage: `lazygit` inside a repo when you want an interactive Git workflow. |
| `atuin` | Searchable, sync-capable shell history replacement/enhancement. | Not installed or initialized by default; add it manually only after deciding whether to enable history sync. Common usage: `atuin search`, `atuin import auto`, `atuin stats`. |
| `tealdeer` / `tldr` | Fast Rust client for TLDR community command examples. | Command is usually `tldr`. Common usage: `tldr tar`, `tldr rg`, `tldr git rebase`, `tldr --update`. |
| `mise` | Polyglot runtime/tool version manager, useful as a broader alternative to single-language managers. | Not installed or hooked by default to avoid changing project environments unexpectedly. Common usage: `mise use node@22`, `mise install`, `mise exec -- command`, `mise current`. |
| `jq` | JSON processor for filtering, transforming, and pretty-printing JSON in pipelines. | No alias; use directly. Common usage: `jq . file.json`, `curl ... \| jq`, `jq -r '.items[].name'`. |
| `yq` | YAML, JSON, XML, CSV, and TOML processor with jq-like query syntax. | No alias; use directly. Common usage: `yq . file.yml`, `yq '.services.web.image' docker-compose.yml`, `yq -o=json . file.yml`. |
| `jless` | Interactive terminal JSON viewer with structural navigation and search. | No alias; use directly. Common usage: `jless file.json`, `curl ... \| jless`. |
| `fx` | Interactive JSON viewer and processor, useful for exploring API responses and applying JavaScript snippets. | No alias; use directly. Common usage: `fx file.json`, `curl ... \| fx`, `fx data.json 'x => x.items.length'`. |
| `doggo` / `dog` | Human-friendly DNS lookup client for quick record checks. | Homebrew installs `doggo`; Fish aliases `dog` to `doggo` when no real `dog` command exists. Common usage: `dog example.com`, `dog MX example.com`, `dog @1.1.1.1 example.com`. |
| `bandwhich` | Terminal bandwidth monitor that shows network usage by process, connection, and remote host. | No alias; often needs elevated permissions for full visibility. Common usage: `sudo bandwhich`, `bandwhich --raw`. |
| `tcping` | TCP connectivity checker, useful when ICMP ping is blocked or you need to test a specific port. | No alias; use directly. Common usage: `tcping example.com 443`, `tcping 10.0.0.1 22`. |
| `visidata` / `vd` | Terminal spreadsheet and data exploration tool for CSV, TSV, JSON, JSONL, SQLite, Excel, and more. | No alias; command is usually `vd`. Common usage: `vd data.csv`, `vd logs.jsonl`, `vd database.sqlite`. |
| `jujutsu` / `jj` | Git-compatible distributed version control system with a modern workflow for changes, rebasing, and history editing. | No alias and no Git config changes; install it as an optional tool and opt into using it per repo. Common usage: `jj git init --colocate`, `jj status`, `jj log`. |
| `sd` | Simple, fast, regex-aware find-and-replace tool with friendlier syntax than many `sed` substitutions. | No alias; use directly. Common usage: `sd old new file`, `sd 'foo(.*)' 'bar$1' src/**/*.rs`. |
| `just` | Command runner for project tasks, similar to `make` but with a simpler `justfile` syntax. | No alias; use directly. Common usage: `just`, `just --list`, `just test`, `just build`. |
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
