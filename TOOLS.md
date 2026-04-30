# Tool Notes

This repo expects a few command-line tools that may not be installed by default on a new machine. They are grouped by workflow below; each table explains what the tool does, how this dotfiles repo wires it in, and a few common commands to try.

## Shell UX And Navigation

| Tool | Why it is used | Config, aliases, and common usage |
| --- | --- | --- |
| `starship` | Cross-shell prompt used by both Zsh and Fish configs. | Config lives at `starship/.config/starship.toml`. Common usage: `starship explain`, `starship timings`, `starship print-config`. |
| `zoxide` | Smarter `cd` command that learns frequently used directories. | Fish config runs `zoxide init fish \| source`, which provides `z` and `zi`. Common usage: `z repo`, `z dotfiles`, `zi` for interactive directory selection, `zoxide query name`. |
| `fzf` | Interactive fuzzy finder used for shell history, directory jumping, git status/log pickers, and file selection. | Fish uses `patrickf1/fzf.fish`. Key bindings: `Ctrl-R` history, `Ctrl-G` directories, `Ctrl-S` git status, `Ctrl-L` git log, `Ctrl-P` processes, `Ctrl-V` variables. Common usage: `fzf`, `git branch \| fzf`. |
| `atuin` | Searchable, sync-capable shell history replacement/enhancement. | Not installed or initialized by default; add it manually only after deciding whether to enable history sync. Common usage: `atuin search`, `atuin import auto`, `atuin stats`. |
| `dircolors` | Provides GNU `LS_COLORS`; on macOS it comes from Homebrew `coreutils`. | Used by shell configs when `~/.dircolors` exists. Common usage: `dircolors -b ~/.dircolors` prints shell code for colorized GNU `ls`. |
| `bash-completion` | Adds programmable completions for Bash on systems where Bash is still used. | No Fish alias. Common usage: install it when you still use Bash configs; Bash will source completion scripts from standard locations. |
| `fisher` | Fish plugin manager; used here to install and restore Fish plugins from `fish_plugins`. | Current plugin list lives in `fish/.config/fish/fish_plugins`. Common usage: `fisher install owner/repo`, `fisher remove owner/repo`, `fisher update`. |

## Search, Files, And Viewing

| Tool | Why it is used | Config, aliases, and common usage |
| --- | --- | --- |
| `ripgrep` / `rg` | Fast recursive text search used as a modern replacement for many `grep -R` workflows. | No alias; use directly. Common usage: `rg pattern`, `rg -n "TODO" src`, `rg --files`, `rg -i pattern`. |
| `ripgrep-all` / `rga` | Wrapper around ripgrep for searching rich file types such as PDFs, Office documents, ebooks, archives, SQLite databases, and media metadata. | No alias; use `rg` for code and `rga` for documents/binary-rich files. Common usage: `rga keyword ~/Documents`, `rga -i invoice .`. |
| `fd` | Fast, user-friendly file finder used as a modern replacement for many `find` workflows. | Fish alias: `f='fd'`. Common usage: `fd name`, `fd -e ts`, `fd config ~/.config`, `fd -H pattern` to include hidden files. |
| `bat` | Syntax-highlighted file viewer used as a nicer `cat`/pager companion. | Fish alias: `c='bat'`. Common usage: `bat file`, `bat -n file`, `bat --paging=never file`, `bat -p file` for plain output. |
| `eza` / `exa` | Modern `ls` replacement with better defaults and directory grouping. | Fish aliases `ls` to `eza --group-directories-first` when available, otherwise `exa`, otherwise macOS `ls -G`. Related aliases: `ll='ls -lah'`, `la='ls -A'`, `l='ls -CF'`. |
| `yazi` | Terminal file manager with fast navigation and previews. | Fish alias: `yy='yazi'`; Fish function `y` opens Yazi and changes the shell to Yazi's last directory on exit. Common usage: `y`, `yy`, `y path/to/dir`. |

## Git And Version Control

| Tool | Why it is used | Config, aliases, and common usage |
| --- | --- | --- |
| `git-delta` / `delta` | Pretty pager for `git diff`, `git show`, and interactive diffs. | Git config sets `core.pager=delta` and `interactive.diffFilter=delta --color-only`. Common usage: `git diff`, `git show`, `git log -p`; run `delta --help` for themes/options. |
| `lazygit` | Terminal UI for Git status, staging, commits, branches, stash, and logs. | No alias; use directly. Common usage: `lazygit` inside a repo when you want an interactive Git workflow. |
| `jujutsu` / `jj` | Git-compatible distributed version control system with a modern workflow for changes, rebasing, and history editing. | No alias and no Git config changes; install it as an optional tool and opt into using it per repo. Common usage: `jj git init --colocate`, `jj status`, `jj log`. |

## Data And Structured Text

| Tool | Why it is used | Config, aliases, and common usage |
| --- | --- | --- |
| `jaq` / `jq` | Fast JSON processor for filtering, transforming, and pretty-printing JSON in pipelines. | Interactive shells alias `jq` to `jaq` when `jaq` is installed. Common usage: `jq . file.json`, `curl ... \| jq`, `jq -r '.items[].name'`. |
| `yq` | YAML, JSON, XML, CSV, and TOML processor with jq-like query syntax. | No alias; use directly. Supports in-place edits with `-i`. Common usage: `yq . file.yml`, `yq '.services.web.image' docker-compose.yml`, `yq -i '.services.web.image = "app:latest"' docker-compose.yml`. |
| `jless` | Interactive terminal JSON viewer with structural navigation and search. | No alias; use directly. Common usage: `jless file.json`, `curl ... \| jless`. |
| `fx` | Interactive JSON viewer and processor, useful for exploring API responses and applying JavaScript snippets. | No alias; use directly. Common usage: `fx file.json`, `curl ... \| fx`, `fx data.json 'x => x.items.length'`. |
| `dasel` | Query and edit JSON, YAML, TOML, XML, and CSV from one command. | No alias; use directly. Common usage: `dasel -f config.yml '.services.web.image'`, `dasel put -f config.yml -t string '.services.web.image' app:latest`. |
| `gron` | Flattens JSON into greppable assignment lines and can turn them back into JSON. | No alias; use directly. Common usage: `gron data.json`, `curl ... \| gron \| grep id`, `gron --ungron flat.txt`. |
| `moreutils` / `sponge` | Extra Unix pipeline helpers; `sponge` reads stdin before writing a file, making safe in-place pipeline edits easier. | No alias; use directly. Common usage: `jq '.items |= sort' data.json \| sponge data.json`, `grep -v debug app.conf \| sponge app.conf`. |
| `visidata` / `vd` | Terminal spreadsheet and data exploration tool for CSV, TSV, JSON, JSONL, SQLite, Excel, and more. | No alias; command is usually `vd`. Common usage: `vd data.csv`, `vd logs.jsonl`, `vd database.sqlite`. |
| `sd` | Simple, fast, regex-aware find-and-replace tool with friendlier syntax than many `sed` substitutions. | No alias; use directly. Common usage: `sd old new file`, `sd 'foo(.*)' 'bar$1' src/**/*.rs`. |

## Archives

| Tool | Why it is used | Config, aliases, and common usage |
| --- | --- | --- |
| `ouch` | Friendly archive compression and extraction tool that infers formats from filenames. | No alias; use directly. Common usage: `ouch decompress archive.tar.gz`, `ouch compress src output.zip`, `ouch list archive.7z`. |

## Project Environments And Tasks

| Tool | Why it is used | Config, aliases, and common usage |
| --- | --- | --- |
| `direnv` | Loads per-project environment variables from `.envrc` when entering a directory. | Fish config runs `direnv hook fish \| source`. Common usage: create `.envrc`, run `direnv allow`, then `direnv status` or `direnv reload`. |
| `fnm` | Fast Node.js version manager with good Fish shell integration. | Fish config runs `fnm env --use-on-cd --shell fish \| source`. Common usage: `fnm install --lts`, `fnm use 22`, `fnm default 22`, `fnm current`, `fnm list`. |
| `mise` | Polyglot runtime/tool version manager, useful as a broader alternative to single-language managers. | Not installed or hooked by default to avoid changing project environments unexpectedly. Common usage: `mise use node@22`, `mise install`, `mise exec -- command`, `mise current`. |
| `just` | Command runner for project tasks, similar to `make` but with a simpler `justfile` syntax. | No alias; use directly. Common usage: `just`, `just --list`, `just test`, `just build`. |

## System, Disk, And Network

| Tool | Why it is used | Config, aliases, and common usage |
| --- | --- | --- |
| `dust` | Visual disk-usage viewer used as a clearer replacement for many `du` workflows. | Fish alias: `dsize='dust'`. Common usage: `dust`, `dust -d 2`, `dust ~/Downloads`. |
| `bottom` / `btm` | Terminal system monitor with detailed CPU, memory, disk, network, temperature, and process panels. | Fish alias: `sysmon='btm'`. Common usage: `btm`, `btm --basic`, `btm --battery`. |
| `btop` | Polished interactive process and resource monitor; a nicer daily replacement for `top`/`htop`. | Fish alias: `topplus='btop'`. Common usage: `btop`; use it when you want a quick visual process/resource overview. |
| `doggo` / `dog` | Human-friendly DNS lookup client for quick record checks. | Homebrew installs `doggo`; Fish aliases `dog` to `doggo` when no real `dog` command exists. Common usage: `dog example.com`, `dog MX example.com`, `dog @1.1.1.1 example.com`. |
| `bandwhich` | Terminal bandwidth monitor that shows network usage by process, connection, and remote host. | No alias; often needs elevated permissions for full visibility. Common usage: `sudo bandwhich`, `bandwhich --raw`. |
| `tcping` | TCP connectivity checker, useful when ICMP ping is blocked or you need to test a specific port. | No alias; use directly. Common usage: `tcping example.com 443`, `tcping 10.0.0.1 22`. |
| `coreutils` | Installs GNU utilities on macOS, including `dircolors`/`gdircolors`. | No alias in this repo. Common usage on macOS: GNU tools are usually prefixed with `g`, such as `gdate`, `gsed`, and `gdircolors`. |
| `cloudflared` | Provides the SSH proxy command needed to connect to `git-ssh.linu.me`. | Used by `ssh/.ssh/config` for the internal Git SSH host. Common usage: normal `git fetch`/`git push` to `git-ssh.linu.me`; `cloudflared` runs behind the SSH config. |

## Reference And Desktop Automation

| Tool | Why it is used | Config, aliases, and common usage |
| --- | --- | --- |
| `tealdeer` / `tldr` | Fast Rust client for TLDR community command examples. | Command is usually `tldr`. Common usage: `tldr tar`, `tldr rg`, `tldr git rebase`, `tldr --update`. |
| `espanso` | Cross-platform text expander for snippets and typing automation. | Installed as a Homebrew cask; macOS requires Accessibility permission before expansion works. Common usage: configure matches under Espanso config, then run `espanso start`, `espanso status`, `espanso edit`. |

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
