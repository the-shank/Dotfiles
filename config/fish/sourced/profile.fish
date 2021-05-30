# NOTE: for any environment variable related stuff see setup.fish

# autojump
test -e "/usr/share/autojump/autojump.fish"; 
    and source "/usr/share/autojump/autojump.fish"

# ssh-agent
# source: https://unix.stackexchange.com/a/132117
test -d $XDG_RUNTIME_DIR; and setenv SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"  
ssh-add -l >/dev/null 2>&1
if test $status -ge 2
    echo "starting ssh-agent"
    ssh-agent -a $SSH_AUTH_SOCK >/dev/null
end

# in case there is a .private file, source it
test -e "$HOME/.private"; and source $HOME/.private

# asdf
test -e "$HOME/.asdf/asdf.fish"; and source "$HOME/.asdf/asdf.fish"

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;9m'      # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline
