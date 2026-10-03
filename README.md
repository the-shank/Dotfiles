# Shank's dotfiles

Use [GNU Stow](https://www.gnu.org/software/stow/) to manage these dotfiles.

To _stow_ dotfiles for a particular package (for e.g. neovim):

```shell
stow --no-folding --verbose --restow neovim
```

To remove previously _stowed_ files for a particular package (for e.g. neovim):

```shell
stow --no-folding --verbose --delete neovim
```

