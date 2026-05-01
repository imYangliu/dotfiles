# Short aliases for modern CLI tools without shadowing POSIX defaults.
type -q bat; and alias c='bat'
if type -q fd
    alias f='fd'
else if type -q fdfind
    alias f='fdfind'
    alias fd='fdfind'
end
type -q dust; and alias dsize='dust'
type -q btm; and alias sysmon='btm'
type -q btop; and alias topplus='btop'
type -q yazi; and alias yy='yazi'
type -q doggo; and not type -q dog; and alias dog='doggo'
type -q jaq; and alias jq='jaq'
