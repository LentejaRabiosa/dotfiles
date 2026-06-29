# My shitty . files
Note that `stow` is being used here to setup the dotfiles in place.
Clone the repo at home and run `stow --adopt .` (be careful).

 - arch linux install & setup scripts
 - hyprland & waybar
 - foot terminal
 - bash
 - neovim

## Arch Linux install
You can see the packages in `packages.txt`.

 1. Set up partitions and file system
 2. Connect to the internet
 3. Run `arch-install.sh`
 4. On success, run `arch-setup.sh`

## More scripts
 - `nmcli-connect-eduroam.sh` adds and configures an eduroam connection

## Neovim
Super simple and native config. No fancy plugins, only the important ones.

 - [vim-fugitive](https://github.com/tpope/vim-fugitive)
 - [vim-surround](https://github.com/tpope/vim-surround)
 - [vim-repeat](https://github.com/tpope/vim-repeat)
 - [vim-vinegar](https://github.com/tpope/vim-vinegar)

The `:find` command has it's own custom `findfunc` using `fd` and `vim.fn.matchfuzzy`.

## TO-DO
 - [ ] Bootloader restore script
 - [ ] SSH key generation script (for github keys)
