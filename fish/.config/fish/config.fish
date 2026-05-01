# Fish defaults for terminal-heavy development.

if status is-interactive
    set -g fish_greeting
    set -g fish_escape_delay_ms 10
    fish_vi_key_bindings

    if type -q starship
        starship init fish | source
    end
end

# Load private fish overrides last.
if test -r "$HOME/.config/fish/local.fish"
    source "$HOME/.config/fish/local.fish"
end
