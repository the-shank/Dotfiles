function fish_user_key_bindings -d "use Ctrl-f to accept suggestions in vi mode"
    fish_vi_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
        bind -M $mode \ef nextd-or-forward-word
    end
end

# somehow removing this makes fzf keybindings not being available ¯\_(ツ)_/¯
# fzf_key_bindings
