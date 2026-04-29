# Homebrew shell environment and mirrors.
if test -x /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv fish)
else if test -x /usr/local/bin/brew
    eval (/usr/local/bin/brew shellenv fish)
else if test -x /home/linuxbrew/.linuxbrew/bin/brew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)
end

set -gx HOMEBREW_BREW_GIT_REMOTE 'https://mirrors.ustc.edu.cn/brew.git'
set -gx HOMEBREW_CORE_GIT_REMOTE 'https://mirrors.ustc.edu.cn/homebrew-core.git'
set -gx HOMEBREW_BOTTLE_DOMAIN 'https://mirrors.ustc.edu.cn/homebrew-bottles'
set -gx HOMEBREW_API_DOMAIN 'https://mirrors.ustc.edu.cn/homebrew-bottles/api'
