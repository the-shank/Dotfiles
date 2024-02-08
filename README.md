# Shank's dotfiles

Use [GNU Stow](https://www.gnu.org/software/stow/) to use these dotfiles.

To _stow_ dotfiles for a particular package (for e.g. neovim):

```shell
stow --no-folding --verbose -R neovim
```

To remove previously _stow_ed files for a particular package (for e.g. neovim):

```shell
stow --no-folding --verbose -D neovim
```
