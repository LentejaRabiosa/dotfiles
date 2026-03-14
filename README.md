# My shitty . files

 - arch linux install & setup scripts
 - neovim
 - fish
 - foot
 - niri/hyprland/sway with waybar

## Arch Linux install scripts

 1. Set up partitions and file system
 2. Connect to the internet
 3. Run `arch-install.sh`
 4. On success, run `arch-post-install.sh`

Note: `nmcli-connect-eduroam.sh` is a command template, not a script (yet)

## Neovim
There is no third party plugin manager for this config. All plugins repos are
cloned inside `.local/share/nvim/site/pack/manual/start/` directory using the
`install-neovim-plugins.sh` script.

Looking to clone plugins in `.config/nvim/pack/nvim/start/` instead to be able
to replace the script.

## Fish
Nothing special, just `pure` plugin installed with `fisher` plugin manager.
There is a `theme.fish` function to select different variants from the kanso
theme used by neovim and foot.

## Foot
Nothing special.

## Other programs
 - firefox
 - zathura

## TO-DO
 - SSH key generation script (for github keys)
 - Better git diffs config
 - Neovim plugins in .config/nvim/pack/nvim/start/
