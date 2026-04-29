# Common interactive tools.
if status is-interactive
    set -gx FZF_TMUX 1
    set -gx FZF_TMUX_HEIGHT '40%'
    set -gx FZF_CTRL_T_OPTS '--walker-skip .git,node_modules,.venv,venv,dist,build,target'
    set -gx FZF_ALT_C_OPTS '--walker-skip .git,node_modules,.venv,venv,dist,build,target'

    if type -q fnm
        fnm env --use-on-cd --shell fish | source
    end

    if type -q direnv
        direnv hook fish | source
    end

    if type -q zoxide
        zoxide init fish | source
    end

    if type -q fzf_configure_bindings
        fzf_configure_bindings --directory=\cg --history=\cr --git_status=\cs --git_log=\cl --processes=\cp --variables=\cv
    else if type -q fzf; and test -r /opt/homebrew/opt/fzf/shell/key-bindings.fish
        source /opt/homebrew/opt/fzf/shell/key-bindings.fish
    end

    if test -r "$HOME/.openclaw/completions/openclaw.fish"
        source "$HOME/.openclaw/completions/openclaw.fish"
    end
end
