# Homebrew shell environment and mirrors.
if test -x /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv fish)
end

set -gx HOMEBREW_BREW_GIT_REMOTE 'https://mirrors.ustc.edu.cn/brew.git'
set -gx HOMEBREW_CORE_GIT_REMOTE 'https://mirrors.ustc.edu.cn/homebrew-core.git'
set -gx HOMEBREW_BOTTLE_DOMAIN 'https://mirrors.ustc.edu.cn/homebrew-bottles'
set -gx HOMEBREW_API_DOMAIN 'https://mirrors.ustc.edu.cn/homebrew-bottles/api'
