function y --wraps yazi --description 'Open yazi and cd to its last directory on exit'
    set -l tmp (mktemp -t yazi-cwd.XXXXXX)
    yazi $argv --cwd-file=$tmp

    if test -r $tmp
        set -l cwd (cat $tmp)
        if test -n "$cwd"; and test "$cwd" != "$PWD"
            cd -- "$cwd"
        end
    end

    rm -f -- $tmp
end
