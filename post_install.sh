EXTENSIONS=(
    "felipecaputo.git-project-manager",
    "Gruntfuggly.activitusbar",
    "JakeBecker.elixir-ls",
    "ms-python.python",
    "ms-vscode.sublime-keybindings",
    "PeterJausovec.vscode-docker",
    "tomphilbin.gruvbox-themes",
    "vscoss.vscode-ansible"
)

for extension in $EXTENSIONS; do
    code --install-extension $extension
done