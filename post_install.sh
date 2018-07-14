EXTENSIONS=(
    "felipecaputo.git-project-manager"
    "Gruntfuggly.activitusbar"
    "JakeBecker.elixir-ls"
    "ms-python.python"
    "ms-vscode.sublime-keybindings"
    "PeterJausovec.vscode-docker"
    "tomphilbin.gruvbox-themes"
    "vscoss.vscode-ansible"
)

for index in ${!EXTENSIONS[@]}; do
    echo "installing vscode extension: ${EXTENSIONS[$index]}"
    code --install-extension ${EXTENSIONS[$index]}
done