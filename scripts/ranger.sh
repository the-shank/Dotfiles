if [ -e $HOME/.config/ranger/plugins/ranger_devicons ]; then
    echo "ranger devicions already installed"
else
    echo "cloning ranger devicons"
    git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
fi
