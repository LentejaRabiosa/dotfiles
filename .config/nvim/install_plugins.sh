#!/bin/bash
path=".local/share/nvim/site/pack/manual/start"
mkdir -p "$path"

git -C "$path" clone https://github.com/saghen/blink.cmp.git
git -C "$path" fetch --tags
git -C "$path" switch --detach v1.8.0
git -C "$path" clone https://github.com/ibhagwan/fzf-lua.git
git -C "$path" clone https://github.com/nvim-treesitter/nvim-treesitter.git
git -C "$path" clone https://github.com/webhooked/kanso.nvim.git
