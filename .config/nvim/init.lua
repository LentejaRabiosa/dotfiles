-- TODO
--   clipboard
--   keymaps

vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.termguicolors = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.swapfile = false
vim.o.winborder = "solid"
vim.o.undofile = true
vim.o.undodir = "/home/alex/.undodir"
vim.o.incsearch = true
vim.o.smartindent = true
vim.o.ignorecase = true

local map = vim.keymap.set

map("n", "<leader>o", ":update<CR> :source<CR>")

vim.pack.add({
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/stevearc/oil.nvim" },
})

require "nvim-treesitter.configs".setup({
	ensure_installed = { "svelte", "typescript", "javascript", "cpp", "rust", "astro" },
	highlight = { enable = true },
	modules = {},
	sync_install = true,
	ignore_install = {},
	auto_install = false,
})

local fzf = require("fzf-lua")
fzf.setup({
	"fzf-vim",
	winopts = {
		border = "solid",
	},
})
map("n", "<leader>f", fzf.files)
map("n", "<leader>b", fzf.buffers)
map("n", "<leader>ls", fzf.lsp_document_symbols)
map("n", "<leader>ld", fzf.diagnostics_document)
map("n", "<leader>r", fzf.registers)

require("oil").setup({
	confirmation = {
		border = "solid",
	},
})
map("n", "-", "<CMD>Oil<CR>")

map("n", "<leader>lf", vim.lsp.buf.format)
map("n", "<leader>lr", vim.lsp.buf.rename)
vim.lsp.enable({ "lua_ls", "clangd", "rust_analyzer", "svelte", "astro", "ts_ls" })
vim.cmd("set completeopt+=noselect")

require("kanagawa").setup()
vim.cmd("colorscheme kanagawa-dragon")
