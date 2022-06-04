function fish_user_key_bindings -d "use Ctrl-f to accept suggestions in vi mode"
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end
