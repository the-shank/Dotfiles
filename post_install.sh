# ========= UTILS ===================

# contains arr value
function contains() 
{
    local array="$1[@]"
    local seeking=$2
    local notfound=1
    for element in ${!array}; do
        if [[ $element == $seeking ]]; then
            notfound=0
            break
        fi
    done
    return $notfound
}

# =====================================

function vscode_setup()
{
    echo "Installing VSCode extensions"

    InstalledExtensions=$(code --list-extensions)

    RequiredExtensions=(
            "Gruntfuggly.activitusbar"          # Activitus Bar
            "vscoss.vscode-ansible"             # Ansible
            "bungcip.better-toml"               # Better TOML
            "alefragnani.bookmarks"             # Bookmarks
            "formulahendry.code-runner"         # Code Runner
            "PeterJausovec.vscode-docker"       # Docker
            "JakeBecker.elixir-ls"              # ElixirLS
            "pgourlain.erlang"                  # Erlang
            "sleistner.vscode-fileutils"        # File Utils
            "felipecaputo.git-project-manager"  # Git Project Manager
            "jdinhlife.gruvbox"                 # Gruvbox Theme
            "karyfoundation.theme-karyfoundation-themes"    # Kary Pro Colors
            "hangxingliu.vscode-nginx-conf-hint"            # nginx.conf hint
            "passionkind.prettier-vscode-with-tabs"         # Prettier - JavaScript Formatter
            "ms-python.python"                  # Python
            "burkeholland.simple-timer"         # Simple Timer
            "ms-vscode.sublime-keybindings"     # Sublime Text Keymap and Settings
            "octref.vetur"                      # Vetur
        )

    for extn in ${RequiredExtensions[@]}; do
        contains InstalledExtensions $extn && present="yes" || present="no"
        if test $present = "yes" ; then
            echo "> $extn already installed, skipping..."
        else
            echo "> installing vscode extension: ${extn}"
            code --install-extension ${extn}
        fi
    done
}

vscode_setup