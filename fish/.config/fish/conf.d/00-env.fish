# Portable environment defaults. Put machine-local secrets in ~/.config/fish/local.fish.

if test -r "$HOME/.local/bin/env.fish"
    source "$HOME/.local/bin/env.fish"
end

# Ghostty defaults to xterm-ghostty, but some environments can't resolve its terminfo entry.
if set -q TERM; and test "$TERM" = xterm-ghostty; and not infocmp xterm-ghostty >/dev/null 2>&1
    set -gx TERM xterm-256color
end

# Package/runtime mirrors.
set -gx GOPROXY 'https://mirrors.aliyun.com/goproxy/,direct'
set -gx NVM_NODEJS_ORG_MIRROR 'https://npmmirror.com/mirrors/node/'
set -gx FNM_NODE_DIST_MIRROR 'https://npmmirror.com/mirrors/node'
