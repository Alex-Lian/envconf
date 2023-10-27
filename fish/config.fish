if status is-interactive
    # Commands to run in interactive sessions can go here
 
# bind ctrl-f to forward-char
function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end

bind -M insert -m default jj 'commandline -f repaint'
end

