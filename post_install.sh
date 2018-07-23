EXTENSIONS=(
    "felipecaputo.git-project-manager"
    "Gruntfuggly.activitusbar"
    "JakeBecker.elixir-ls"
    "ms-python.python"
    "ms-vscode.sublime-keybindings"
    "PeterJausovec.vscode-docker"
    "jdinhlife.gruvbox"
    "vscoss.vscode-ansible"
    "bungcip.better-toml"
    "hangxingliu.vscode-nginx-conf-hint"
    "burkeholland.simple-timer"
)

for index in ${!EXTENSIONS[@]}; do
    echo "installing vscode extension: ${EXTENSIONS[$index]}"
    code --install-extension ${EXTENSIONS[$index]}
done