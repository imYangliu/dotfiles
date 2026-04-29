# Fish abbreviations expand after typing, keeping history readable.
if status is-interactive
    abbr -a -- gst 'git status -sb'
    abbr -a -- ga 'git add'
    abbr -a -- gc 'git commit'
    abbr -a -- gcm 'git commit -m'
    abbr -a -- gp 'git push'
    abbr -a -- gl 'git pull'
    abbr -a -- gco 'git checkout'
    abbr -a -- gsw 'git switch'
    abbr -a -- gd 'git diff'
    abbr -a -- lg 'git log --graph --decorate --date=short --pretty=format:"%C(yellow)%h%Creset %Cgreen%ad%Creset %C(cyan)%an%Creset %C(auto)%d%Creset %s"'
end
