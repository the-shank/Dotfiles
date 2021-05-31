# download latest neovim appimage release
function nvim-update --description "update nvim to the latest release"
    cd ~/Downloads
    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
    chmod u+x nvim.appimage
    mv -f nvim.appimage ~/.local/bin/nvim
    cd -
end
