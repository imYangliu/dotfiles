# Fish defaults for terminal-heavy development.

# Fix: override SHELL inherited from zsh to prevent Ghostty shell integration
# from injecting zsh-specific TRAPEXIT code into subshells.
if command -q fish
    set -gx SHELL (command -s fish)
end

if status is-interactive
    set -g fish_greeting
    set -g fish_escape_delay_ms 10
    fish_vi_key_bindings

    if type -q starship
        starship init fish | source
    end
end

# deep-claude: Claude Code via model-proxy with DeepSeek models
function deep-claude
    set -gx ANTHROPIC_BASE_URL (string replace -r '/v1/?$' '' -- $MODEL_PROXY_API_BASE)
    set -gx ANTHROPIC_AUTH_TOKEN $MODEL_PROXY_API_KEY
    set -gx ANTHROPIC_MODEL deepseek-v4-pro
    set -gx ANTHROPIC_DEFAULT_OPUS_MODEL deepseek-v4-pro
    set -gx ANTHROPIC_DEFAULT_SONNET_MODEL deepseek-v4-pro
    set -gx ANTHROPIC_DEFAULT_HAIKU_MODEL deepseek-v4-flash
    set -gx CLAUDE_CODE_SUBAGENT_MODEL deepseek-v4-flash
    set -gx CLAUDE_CODE_EFFORT_LEVEL max
    echo "deep-claude: deepseek-v4-pro / deepseek-v4-flash"
    claude --dangerously-skip-permissions $argv
end

# ccr-claude: Claude Code via model-proxy with Claude models
function ccr-claude
    set -gx ANTHROPIC_BASE_URL (string replace -r '/v1/?$' '' -- $MODEL_PROXY_API_BASE)
    set -gx ANTHROPIC_AUTH_TOKEN $MODEL_PROXY_API_KEY
    set -gx ANTHROPIC_MODEL claude-opus-4-7
    set -gx ANTHROPIC_DEFAULT_OPUS_MODEL claude-opus-4-7
    set -gx ANTHROPIC_DEFAULT_SONNET_MODEL claude-sonnet-4-6
    set -gx ANTHROPIC_DEFAULT_HAIKU_MODEL claude-haiku-4-5-20251001
    set -gx CLAUDE_CODE_SUBAGENT_MODEL claude-haiku-4-5-20251001
    set -gx CLAUDE_CODE_EFFORT_LEVEL max
    echo "ccr-claude: opus-4-7 / sonnet-4-6 / haiku-4-5"
    claude --dangerously-skip-permissions $argv
end

# ccr-codex: Codex via model-proxy
function ccr-codex
    echo "ccr-codex: gpt-5.5 via model-proxy"
    codex -c model_provider=proxy -c model=gpt-5.5 $argv
end

# deep-codex: Codex via model-proxy with DeepSeek models
function deep-codex
    echo "deep-codex: deepseek-v4-pro via model-proxy"
    codex -c model_provider=proxy -c model=deepseek-v4-pro \
          -c model_providers.proxy.requires_openai_auth=false \
          $argv
end

# Load private fish overrides last.
if test -r "$HOME/.config/fish/local.fish"
    source "$HOME/.config/fish/local.fish"
end
