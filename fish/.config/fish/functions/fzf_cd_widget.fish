function fzf_cd_widget --description 'Pick a directory with fzf and cd into it'
    type -q fzf; or return 0
    set -l height 40%
    set -q FZF_TMUX_HEIGHT; and set height "$FZF_TMUX_HEIGHT"
    set -l dir (command find -L . \( -path '*/.git' -o -path '*/node_modules' -o -path '*/.venv' -o -path '*/venv' -o -path '*/dist' -o -path '*/build' -o -path '*/target' \) -prune -o -type d -print 2>/dev/null | sed -e 's#^\./##' -e '/^$/d' | command fzf --height="$height" --reverse --prompt='cd> ')
    test -n "$dir"; and commandline -r "cd -- "(string escape -- "$dir"); and commandline -f execute
end
