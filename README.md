# My shitty . files
Note that `stow` is being used here to setup the dotfiles in place.
Clone the repo at home and run `stow --adopt .` (be careful).

 - arch linux install & setup scripts
 - hyprland & waybar
 - foot terminal
 - bash
 - neovim

## Arch Linux install scripts

 1. Set up partitions and file system
 2. Connect to the internet
 3. Run `arch-install.sh`
 4. On success, run `arch-post-install.sh`

Note: `nmcli-connect-eduroam.sh` is a command template, not a script (yet)

## Foot

Nothing special here.

## Neovim

Super simple and native config. No fancy plugins, only the important ones.

 - [vim-fugitive](https://github.com/tpope/vim-fugitive)
 - [vim-surround](https://github.com/tpope/vim-surround)
 - [vim-repeat](https://github.com/tpope/vim-repeat)
 - [vim-vinegar](https://github.com/tpope/vim-vinegar)

The `:find` command has it's own custom `findfunc` using `fd` and `vim.fn.matchfuzzy`.

## Bash

Some aliases.

## Other programs

 - firefox
 - zathura
 - stow
 - fuzzel

## TO-DO

 - [ ] Bootloader script
 - [ ] SSH key generation script (for github keys)
 - [ ] Better git diffs config
 - [ ] Turn `nmcli-connect-eduroam.sh` into script
