# GIT
if [ ! -f `which git` ]; then
    echo "Installing git"
    apt-get update && apt-get install -y git
else
    echo "Git already installed"
fi

# ZSH
if [ ! -f `which zsh` ]; then
    echo "Installing zsh"
    apt-get install -y zsh
else
    echo "Zsh already installed"
fi
# Check if oh-my-zsh is installed
OMZDIR="$HOME/.oh-my-zsh"
if [ ! -d "$OMZDIR" ]; then
    echo 'Installing oh-my-zsh'
    /bin/sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
    echo "Oh-my-zsh already installed"
fi
# Change default shell
if [[ ! $SHELL = *zsh ]]; then
    echo 'Changing default shell to zsh'
    if test "$(uname)" = "Darwin" ; then
        # osx
        chsh -s /usr/local/bin/zsh
    else
        # linux
        chsh -s /usr/bin/zsh
    fi
else
    echo 'Already using zsh'
fi

# CREATE DIRECTORIES
echo "Creating required directories"
mkdir -p ~/Applications ~/.local/bin ~/Code ~/.ansible/roles

# POWERLINE FONTS
function install_powerline_fonts() {
    # get the fonts directory
    if test "$(uname)" = "Darwin" ; then
        # MacOS
        font_dir="$HOME/Library/Fonts"
    else
        # Linux
        font_dir="$HOME/.local/share/fonts"
    fi

    # check if the powerline fonts have already been installed
    if [ -e $font_dir/"Ubuntu Mono derivative Powerline.ttf" ]; then
        installed="true"
    else
        installed="false"
    fi

    if test installed = "true" ; then
        echo "> installing powerline fonts"
        if test "$(uname)" = "Darwin" ; then
            # osx
            git clone https://github.com/powerline/fonts.git --depth=1
            ./fonts/install.sh
            rm -rf fonts
        else
            # linux
            sudo apt-get install -y fonts-powerline
        fi
    else
        echo "> powerline fonts already installed"
    fi
}

# SPACESHIP PROMPT
function spaceship_prompt() 
{
    echo "Setting up spaceship prompt for zsh"

    # Powerline Fonts
    install_powerline_fonts

    # Symlink spaceship.zsh-theme to your oh-my-zsh custom themes directory
    ZSH_CUSTOM=$HOME/.oh-my-zsh
    if [ -e "$ZSH_CUSTOM/themes/spaceship-prompt" ]; then
        echo "> spaceship theme already downloaded"
    else 
        git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
    fi
    if [ -e "$ZSH_CUSTOM/themes/spaceship.zsh-theme" ]; then
        echo "> spaceship theme already linked"
    else 
        ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
    fi

    # Set ZSH_THEME="spaceship" in your .zshrc
    # taken care of in .zshrc
}
spaceship_prompt

# # MINICONDA
# if [[ `which python` != *"miniconda"* ]]; then
#   echo "Miniconda not installed. Please install and retry."; exit 1
#   # TODO: install miniconda
# else
#   echo "Miniconda already installed"
# fi

# # VSCODE
# if [[ ! -f `which code` ]]; then
#   echo "VSCode not installed. Please install and retry."; exit 1
#   # TODO: install VSCode
# else
#   echo "VSCode already installed"
# fi

# # asdf
# if [[ ! -f `which asdf` ]]; then
#   echo "asdf not installed. Please install and retry."; exit 1
#   # TODO: install VSCode
# else
#   echo "asdf already installed"
# fi