function fish_user_key_bindings -d "user keybindings"
    fish_vi_key_bindings
    # accept suggestion
    for mode in insert default visual
        bind -M $mode \cf forward-char
        bind -M $mode \ef nextd-or-forward-word
    end
    # delete word backword
    for mode in insert default visual
        # using "fish_key_reader", found that <alt-backspace> maps to "\e\x7F"
        bind -M $mode \e\x7F backward-kill-word
    end
end

# somehow removing this makes fzf keybindings not being available ¯\_(ツ)_/¯
# fzf_key_bindings
