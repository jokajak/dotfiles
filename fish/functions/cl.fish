function cl --description 'Change directory and ls'
    set DIR "$argv"
    if test (count $argv) -eq 0
        set DIR $HOME
    end
    cd "$DIR" ; lsd --tree --depth 1 -F -l
end
