# 工具说明

这个 dotfiles 仓库依赖一些新机器上不一定默认安装的命令行工具。下面按工作流归类说明每个工具的作用、本仓库如何接入它，以及常见用法。

## Shell 体验与导航

| 工具 | 用途 | 配置、别名和常见用法 |
| --- | --- | --- |
| `starship` | 跨 shell 的命令提示符，本仓库的 Zsh 和 Fish 都使用它。 | 配置文件在 `starship/.config/starship.toml`。常见用法：`starship explain` 查看当前提示符模块解释，`starship timings` 查看耗时，`starship print-config` 打印最终配置。 |
| `zoxide` | 更智能的 `cd`，会学习你常去的目录。 | Fish 配置执行 `zoxide init fish \| source`，提供 `z` 和 `zi`。常见用法：`z repo`、`z dotfiles`、`zi` 交互选择目录、`zoxide query name` 查询匹配目录。 |
| `fzf` | 交互式模糊搜索器，用于搜索历史、跳目录、选择 git 状态/日志、筛选文件等。 | Fish 使用 `patrickf1/fzf.fish` 插件。快捷键：`Ctrl-R` 搜历史，`Ctrl-G` 搜目录，`Ctrl-S` 搜 git status，`Ctrl-L` 搜 git log，`Ctrl-P` 搜进程，`Ctrl-V` 搜变量。常见用法：`fzf`、`git branch \| fzf`。 |
| `atuin` | 可搜索、可同步的 shell 历史增强工具。 | 不默认安装或初始化，避免在未确认同步策略前改变历史行为。常见用法：`atuin search`、`atuin import auto`、`atuin stats`。 |
| `dircolors` | 提供 GNU `LS_COLORS`，用于让 GNU `ls` 按文件类型显示颜色；macOS/Homebrew 下来自 `coreutils`。 | shell 配置会在存在 `~/.dircolors` 时加载它。常见用法：`dircolors -b ~/.dircolors` 输出可被 shell 执行的颜色配置。 |
| `bash-completion` | 为 Bash 增加可编程补全；在仍使用 Bash 的系统上有用。 | Fish 不使用它。常见用法：安装后 Bash 会从标准路径加载补全脚本。 |
| `fisher` | Fish 插件管理器，用于根据 `fish_plugins` 安装和恢复 Fish 插件。 | 当前插件列表在 `fish/.config/fish/fish_plugins`。常见用法：`fisher install owner/repo`、`fisher remove owner/repo`、`fisher update`。 |

## 搜索、文件与查看

| 工具 | 用途 | 配置、别名和常见用法 |
| --- | --- | --- |
| `ripgrep` / `rg` | 高性能递归文本搜索工具，常用于替代 `grep -R`。 | 没有配置别名，直接使用。常见用法：`rg pattern`、`rg -n "TODO" src`、`rg --files`、`rg -i pattern`。 |
| `ripgrep-all` / `rga` | `ripgrep` 的扩展封装，可搜索 PDF、Office 文档、电子书、压缩包、SQLite 数据库和媒体 metadata 等富文件类型。 | 没有配置别名；代码搜索继续用 `rg`，文档/二进制富文件搜索用 `rga`。常见用法：`rga keyword ~/Documents`、`rga -i invoice .`。 |
| `fd` | 更快、更好用的文件查找工具，常用于替代很多 `find` 场景。 | Fish 别名：`f='fd'`。常见用法：`fd name`、`fd -e ts`、`fd config ~/.config`、`fd -H pattern` 搜索隐藏文件。 |
| `bat` | 带语法高亮的文件查看器，可作为更友好的 `cat`/pager 辅助工具。 | Fish 别名：`c='bat'`。常见用法：`bat file`、`bat -n file` 显示行号、`bat --paging=never file` 禁用分页、`bat -p file` 输出简洁内容。 |
| `eza` / `exa` | 现代版 `ls` 替代工具，默认展示更友好，并支持目录优先。 | Fish 会在可用时把 `ls` 别名到 `eza --group-directories-first`，否则用 `exa`，再否则用 macOS `ls -G`。相关别名：`ll='ls -lah'`、`la='ls -A'`、`l='ls -CF'`。 |
| `yazi` | 终端文件管理器，支持快速导航和预览。 | Fish 别名：`yy='yazi'`；Fish 函数 `y` 会打开 Yazi，并在退出后把当前 shell 切到 Yazi 最后所在目录。常见用法：`y`、`yy`、`y path/to/dir`。 |

## Git 与版本控制

| 工具 | 用途 | 配置、别名和常见用法 |
| --- | --- | --- |
| `git-delta` / `delta` | 美化 `git diff`、`git show`、交互式 diff 的 pager。 | Git 配置里设置了 `core.pager=delta` 和 `interactive.diffFilter=delta --color-only`。常见用法：直接运行 `git diff`、`git show`、`git log -p`；需要调主题/选项时看 `delta --help`。 |
| `bit` / `bit-git` | 更友好的 Git CLI 封装，优化 status、branch、log 和常用工作流输出。 | Fish 补全在 `fish/.config/fish/completions/bit.fish`。常见用法：`bit status`、`bit branch`、`bit log`、`bit add`、`bit commit`；不支持的子命令会回退给 Git。 |
| `lazygit` | Git 终端 UI，用来交互式处理状态、暂存、提交、分支、stash 和日志。 | 没有配置别名，直接使用。常见用法：在仓库里运行 `lazygit`。 |
| `jujutsu` / `jj` | Git-compatible 的分布式版本控制系统，在 changes、rebase、历史编辑方面工作流更现代。 | 没有配置别名，也不改 Git 配置；作为可选工具安装，按仓库选择是否使用。常见用法：`jj git init --colocate`、`jj status`、`jj log`。 |

## 数据与结构化文本

| 工具 | 用途 | 配置、别名和常见用法 |
| --- | --- | --- |
| `jaq` / `jq` | 更快的 JSON 处理器，用于在管道里过滤、转换和格式化 JSON。 | 安装了 `jaq` 时，交互式 shell 会把 `jq` 别名到 `jaq`。常见用法：`jq . file.json`、`curl ... \| jq`、`jq -r '.items[].name'`。 |
| `yq` | YAML、JSON、XML、CSV、TOML 处理器，查询语法接近 `jq`。 | 没有配置别名，直接使用；支持用 `-i` 原地写入。常见用法：`yq . file.yml`、`yq '.services.web.image' docker-compose.yml`、`yq -i '.services.web.image = "app:latest"' docker-compose.yml`。 |
| `jless` | 交互式终端 JSON 查看器，支持按结构导航和搜索。 | 没有配置别名，直接使用。常见用法：`jless file.json`、`curl ... \| jless`。 |
| `fx` | 交互式 JSON 查看和处理工具，适合探索 API 响应并用 JavaScript 片段处理数据。 | 没有配置别名，直接使用。常见用法：`fx file.json`、`curl ... \| fx`、`fx data.json 'x => x.items.length'`。 |
| `dasel` | 用同一套命令查询和编辑 JSON、YAML、TOML、XML、CSV。 | 没有配置别名，直接使用。常见用法：`dasel -f config.yml '.services.web.image'`、`dasel put -f config.yml -t string '.services.web.image' app:latest`。 |
| `gron` | 把 JSON 展平成便于 `grep` 的赋值行，也可以再还原成 JSON。 | 没有配置别名，直接使用。常见用法：`gron data.json`、`curl ... \| gron \| grep id`、`gron --ungron flat.txt`。 |
| `moreutils` / `sponge` | 一组额外 Unix 管道工具；`sponge` 会先读完 stdin 再写文件，适合安全做管道式原地修改。 | 没有配置别名，直接使用。常见用法：`jq '.items |= sort' data.json \| sponge data.json`、`grep -v debug app.conf \| sponge app.conf`。 |
| `visidata` / `vd` | 终端表格和数据探索工具，可查看 CSV、TSV、JSON、JSONL、SQLite、Excel 等。 | 没有配置别名；命令通常是 `vd`。常见用法：`vd data.csv`、`vd logs.jsonl`、`vd database.sqlite`。 |
| `duckdb` | 嵌入式分析型 SQL 数据库，可直接查询本地文件和数据湖，不需要起服务。 | 没有配置别名，直接使用。常见用法：`duckdb`、`duckdb data.db`、`duckdb -c "select * from read_csv_auto('data.csv') limit 10"`。 |
| `sd` | 简洁快速的正则替换工具，比很多 `sed` 替换写法更直观。 | 没有配置别名，直接使用。常见用法：`sd old new file`、`sd 'foo(.*)' 'bar$1' src/**/*.rs`。 |

## 压缩包

| 工具 | 用途 | 配置、别名和常见用法 |
| --- | --- | --- |
| `ouch` | 更友好的压缩和解压工具，会根据文件名推断格式。 | 没有配置别名，直接使用。常见用法：`ouch decompress archive.tar.gz`、`ouch compress src output.zip`、`ouch list archive.7z`。 |

## 项目环境与任务

| 工具 | 用途 | 配置、别名和常见用法 |
| --- | --- | --- |
| `direnv` | 进入目录时自动加载该项目的 `.envrc`，适合管理项目级环境变量。 | Fish 配置执行 `direnv hook fish \| source`。常见用法：创建 `.envrc`，执行 `direnv allow` 授权，然后可用 `direnv status` 或 `direnv reload`。 |
| `fnm` | 快速 Node.js 版本管理器，Fish 集成体验比传统 `nvm.sh` 更好。 | Fish 配置执行 `fnm env --use-on-cd --shell fish \| source`。常见用法：`fnm install --lts`、`fnm use 22`、`fnm default 22`、`fnm current`、`fnm list`。 |
| `mise` | 多语言运行时/工具版本管理器，可作为单语言版本管理器的更通用替代。 | 不默认安装或加 hook，避免意外改变项目环境。常见用法：`mise use node@22`、`mise install`、`mise exec -- command`、`mise current`。 |
| `just` | 项目任务命令运行器，类似 `make`，但 `justfile` 语法更简单。 | 没有配置别名，直接使用。常见用法：`just`、`just --list`、`just test`、`just build`。 |

## 系统、磁盘与网络

| 工具 | 用途 | 配置、别名和常见用法 |
| --- | --- | --- |
| `dust` | 可视化磁盘占用查看器，适合替代很多 `du` 场景。 | Fish 别名：`dsize='dust'`。常见用法：`dust`、`dust -d 2`、`dust ~/Downloads`。 |
| `bottom` / `btm` | 终端系统监控器，集中查看 CPU、内存、磁盘、网络、温度和进程信息。 | Fish 别名：`sysmon='btm'`。常见用法：`btm`、`btm --basic`、`btm --battery`。 |
| `btop` | 更漂亮顺手的交互式进程/资源监控工具，适合日常替代 `top`/`htop`。 | Fish 别名：`topplus='btop'`。常见用法：`btop`；想快速看进程和资源占用时用它。 |
| `doggo` / `dog` | 更适合人看的 DNS 查询客户端，用来快速查记录。 | Homebrew 安装的是 `doggo`；Fish 会在没有真实 `dog` 命令时把 `dog` 别名到 `doggo`。常见用法：`dog example.com`、`dog MX example.com`、`dog @1.1.1.1 example.com`。 |
| `bandwhich` | 终端带宽监控工具，按进程、连接和远端主机展示网络占用。 | 没有配置别名；完整信息通常需要提权。常见用法：`sudo bandwhich`、`bandwhich --raw`。 |
| `tcping` | TCP 连通性检测工具，适合 ICMP ping 被禁或需要测试具体端口时使用。 | 没有配置别名，直接使用。常见用法：`tcping example.com 443`、`tcping 10.0.0.1 22`。 |
| `coreutils` | 在 macOS 上安装 GNU 工具，包括 `dircolors`/`gdircolors` 等。 | 本仓库没有给它配置别名。macOS 上 GNU 工具通常带 `g` 前缀，例如 `gdate`、`gsed`、`gdircolors`。 |
| `cloudflared` | 为连接 `git-ssh.linu.me` 提供 SSH ProxyCommand。 | 被 `ssh/.ssh/config` 中的内部 Git SSH host 使用。常见用法：正常执行 `git fetch` / `git push` 到 `git-ssh.linu.me`，底层由 SSH 配置调用 `cloudflared`。 |

## 参考资料与桌面自动化

| 工具 | 用途 | 配置、别名和常见用法 |
| --- | --- | --- |
| `tealdeer` / `tldr` | Rust 写的快速 TLDR 客户端，用来查看命令示例。 | 命令通常是 `tldr`。常见用法：`tldr tar`、`tldr rg`、`tldr git rebase`、`tldr --update`。 |
| `espanso` | 跨平台文本扩展工具，用于片段替换和输入自动化。 | 通过 Homebrew cask 安装；macOS 需要授予 Accessibility 权限后才能正常扩展。常见用法：配置 Espanso matches，然后运行 `espanso start`、`espanso status`、`espanso edit`。 |

## Git 缩写

Fish abbreviation 会在你确认命令时自动展开，因此历史记录里保留的是完整命令，而不是短缩写。

| 缩写 | 展开为 | 用途 |
| --- | --- | --- |
| `gst` | `git status -sb` | 用紧凑格式查看仓库状态和分支信息。 |
| `ga` | `git add` | 暂存文件。 |
| `gc` | `git commit` | 创建提交。 |
| `gcm` | `git commit -m` | 用行内 message 创建提交。 |
| `gp` | `git push` | 推送当前分支。 |
| `gl` | `git pull` | 从上游拉取更新。 |
| `gco` | `git checkout` | 切换分支或检出路径；保留给旧 Git 工作流。 |
| `gsw` | `git switch` | 切换分支。 |
| `gd` | `git diff` | 查看未暂存 diff，并通过 `delta` 美化显示。 |
| `lg` | `git log --graph ...` | 查看紧凑的带分支装饰提交图。 |
