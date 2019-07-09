for repo in (find ~/git -mindepth 2 -maxdepth 2 -type d)
    complete -f -c repodir -a "(basename \"$repo\")"
end
