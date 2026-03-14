#!/bin/bash
# might be possible to store plugins in dotfiles/.config/nvim
path=".local/share/nvim/site/pack/manual/start"
mkdir -p "$path"

# this needs a fix: the fetch and switch are not being done inside blink.cmp.git
git -C "$path" clone https://github.com/saghen/blink.cmp.git
git -C "$path" fetch --tags
git -C "$path" switch --detach v1.8.0

git -C "$path" clone https://github.com/ibhagwan/fzf-lua.git
git -C "$path" clone https://github.com/nvim-treesitter/nvim-treesitter.git
git -C "$path" clone https://github.com/webhooked/kanso.nvim.git
git -C "$path" clone https://github.com/stevearc/oil.nvim.git
git -C "$path" clone https://github.com/folke/flash.nvim.git
git -C "$path" clone https://github.com/neovim/nvim-lspconfig.git
