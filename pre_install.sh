OS='Ubuntu' # possible Manjaro | Ubuntu | OSX
INSTALL_CMD='sudo apt-get install -y '
UPDATE_REPO_CMD='sudo apt-get -y update'
UPDATE_OS_CMD='sudo apt-get -y upgrade'

function detect_os() {
    UNAME_A=$(uname -a)
    if grep -qi "Ubuntu" <<<$UNAME_A; then
        OS="Ubuntu"
    elif grep -qi "Manjaro" <<<$UNAME_A; then
        OS="Manjaro"
    elif grep -qi "Darwin" <<<$UNAME_A; then
        OS="OSX"
    else
        echo "unknown os: $UNAME_A"
        exit
    fi

    echo "detected os: $OS"
}

function setup_cmds() {
    case $OS in
    Ubuntu)
        INSTALL_CMD='sudo apt-get install -Sy --needed '
        UPDATE_REPO_CMD='sudo apt-get -y update'
        UPDATE_OS_CMD='sudo apt-get -y upgrade'
        ;;

    Manjaro)
        INSTALL_CMD='sudo pacman -S --needed '
        UPDATE_REPO_CMD='sudo pacman -Sy'
        UPDATE_OS_CMD='sudo pacman -Su'
        ;;

    OSX)
        INSTALL_CMD='brew install '
        UPDATE_REPO_CMD='brew update'
        UPDATE_OS_CMD='brew upgrade'
        ;;

    *)
        echo "unsupported OS: $OS"
        exit
        ;;
    esac
}

function install_utils() {
    echo "installing utils - start"

    # [alias] -> util
    declare -A UTILS=(
        [shfmt]=shfmt
        [peco]=peco
        [fd]=fd
        [rg]=ripgrep
        [git]=git
        [zsh]=zsh
    )
    echo "required utils: ${UTILS[@]}"

    INSTALLED=()
    TO_INSTALL=()
    for util in "${!UTILS[@]}"; do
        if [ ! -f $(which "$util") ]; then
            TO_INSTALL+=(${UTILS[$util]})
        else
            # echo "$util already installed"
            INSTALLED+=(${UTILS[$util]})
        fi
    done
    echo "already installed: ${INSTALLED[@]}"
    echo "to install: ${TO_INSTALL[@]}"

    if [ "${#TO_INSTALL[@]}" -eq "0" ]; then
        echo "required utils already installed"
    else
        $INSTALL_CMD${TO_INSTALL[@]}
    fi

    echo "installing utils - complete"
}

function update_os() {
    $UPDATE_REPO_CMD
    $UPDATE_OS_CMD
}

detect_os
setup_cmds
update_os
install_utils

# ZSH ==========================================================================
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
    case $OS in
    Ubuntu | Manjaro)
        chsh -s /usr/bin/zsh
        ;;

    OSX)
        chsh -s /usr/local/bin/zsh
        ;;
    *)
        echo "unsupported os: $OS"
        exit
        ;;
    esac
else
    echo 'Already using zsh'
fi

# ZSH: autosuggestinos
if [ -e ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
    echo "zsh-autosuggestions directory already exists"
else
    echo "downloading zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# ZSH: peco history
if [ -e $HOME/.zsh/zsh-peco-history ]; then
    echo "zsh-peco-history directory already exists"
else
    echo "downloading zsh-peco-history"
    git clone https://github.com/jimeh/zsh-peco-history.git ~/.zsh/zsh-peco-history
fi

# CREATE DIRECTORIES ===========================================================
echo "Creating required directories"
mkdir -p ~/Applications ~/.local/bin ~/Code ~/.ansible/roles ~/Code/UTILS/ANSIBLE-ROLES

# POWERLINE FONTS ==============================================================
function install_powerline_fonts() {
    # get the fonts directory
    case $OS in
    Ubuntu)
        font_dir="$HOME/.local/share/fonts"
        ;;

    Manjaro)
        font_dir="/usr/share/fonts"
        ;;

    OSX)
        font_dir="$HOME/Library/Fonts"
        ;;
    *)
        echo "unsupported os: $OS"
        exit
        ;;
    esac

    # check if the powerline fonts have already been installed
    all_fonts=$(tree $font_dir)
    if grep -qi powerline <<<$all_fonts; then
        echo "> powerline fonts already installed"
    else
        echo "> installing powerline fonts"
        case $OS in

        Ubuntu)
            $INSTALL_CMD"fonts-powerline"
            ;;

        Manjaro)
            yes | $INSTALL_CMD"powerline-fonts"
            ;;

        OSX)
            git clone https://github.com/powerline/fonts.git --depth=1
            ./fonts/install.sh
            rm -rf fonts
            ;;

        *)
            echo "unsupported os: $OS"
            exit
            ;;
        esac
    fi
}
install_powerline_fonts

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
