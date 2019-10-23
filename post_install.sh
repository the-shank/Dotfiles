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
            # LANGUAGES, FRAMEWORKS, TOOLS
            "vscoss.vscode-ansible"                         # Ansible
            "bungcip.better-toml"                           # Better TOML
            "ms-vscode.cpptools"                            # C/C++
            "ms-azuretools.vscode-docker"                   # Docker
            "JakeBecker.elixir-ls"                          # ElixirLS
            "pgourlain.erlang"                              # Erlang
            "hangxingliu.vscode-nginx-conf-hint"            # nginx.conf hint
            "ms-python.python"                              # Python
            "esbenp.prettier-vscode"                        # Prettier - Code Formatter
            "passionkind.prettier-vscode-with-tabs"         # Prettier - JavaScript Formatter
            "redhat.java"                                   # Java
            "VisualStudioExptTeam.vscodeintellicode"        # Java
            "vscjava.vscode-java-debug"                     # Java
            "vscjava.vscode-java-dependency"                # Java
            "vscjava.vscode-java-pack"                      # Java
            "vscjava.vscode-java-test"                      # Java
            "vscjava.vscode-maven"                          # Java
            "rust-lang.rust"                                # Rust
            "octref.vetur"                                  # Vetur

            # UTILS
            "formulahendry.code-runner"                     # Code Runner
            "felipecaputo.git-project-manager"              # Git Project Manager
            "hoangnc.io-run"                                # IORun (for competitive programming)
            "burkeholland.simple-timer"                     # Simple Timer
            "wakatime.vscode-wakatime"                      # WakaTime
            "Gruntfuggly.activitusbar"                      # Activitus Bar
            "ms-vscode.sublime-keybindings"                 # Sublime Text Keymap and Settings
            "alefragnani.bookmarks"                         # Bookmarks
            "sleistner.vscode-fileutils"                    # File Utils
            "shengchen.vscode-leetcode"                     # LeetCode

            # THEMES
            "akamud.vscode-theme-onedark"                   # Atom One Dark
            "tomphilbin.gruvbox-themes"                     # Gruvbox
            "arcticicestudio.nord-visual-studio-code"       # Nord
            "ms-vscode.Theme-TomorrowKit"                   # Tomorrow
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