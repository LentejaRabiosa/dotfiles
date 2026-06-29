# My shitty dotfiles

**Warning:** this repository is highly opinionated and tailored to my own workflow.

The dotfiles are managed with `stow`. Clone the repository into your home directory and run:

```sh
stow --adopt dotfiles
```

## Arch Linux install
The list of packages is defined in `packages.txt`.

 1. Partition and mount your disks.
 2. Connect to the internet.
 3. Run `arch-install.sh`.

## More scripts
 - `nmcli-connect-eduroam.sh` creates and configures an eduroam connection.

## Neovim
A minimal, mostly native configuration with only a few essential plugins.

The `:find` command uses a custom `findfunc` based on `fd` and `vim.fn.matchfuzzy`.

## TODO
 - [ ] Bootloader recovery script
 - [ ] GitHub SSH key generation script
