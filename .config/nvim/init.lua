vim.g.mapleader = " "
vim.g.maplocalleader = ","
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
vim.o.undodir = vim.fn.expand("$HOME/.undodir")
vim.o.incsearch = true
vim.o.smartindent = true
vim.o.ignorecase = true

local map = vim.keymap.set

map("n", "<leader>o", ":update<CR> :source<CR>")
map("n", "<leader>w", ":w<CR>")
map("n", "<leader>a", ":wa<CR>")
map({ 'n', 'v', 'x' }, '<leader>y', '"+y')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d')

-- vim.pack.add({
-- 	{ src = "https://github.com/rebelot/kanagawa.nvim" },
-- 	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
-- 	{ src = "https://github.com/ibhagwan/fzf-lua" },
-- 	{ src = "https://github.com/stevearc/oil.nvim" },
-- 	{ src = "https://github.com/windwp/nvim-autopairs" },
-- 	{ src = "https://github.com/neovim/nvim-lspconfig" },
-- 	{ src = "https://github.com/Saghen/blink.cmp", version = "tags/v1.6.0" },
-- })

require("blink.cmp").setup({
	cmdline = { enabled = true },
	completion = {
		ghost_text = { enabled = true },
	},
	sources = {
		default = { 'lsp', 'buffer', 'snippets', 'path' },
	},
	keymap = {
		['<Tab>'] = { 'select_and_accept', 'fallback' },
	},
	fuzzy = {
		implementation = "prefer_rust_with_warning",
		prebuilt_binaries = {
			download = true,
		},
	},
})

-- require "nvim-treesitter.configs".setup({
-- 	ensure_installed = { "svelte", "typescript", "javascript", "cpp", "rust", "astro", "zig", "python", "go" },
-- 	highlight = { enable = true },
-- 	modules = {},
-- 	sync_install = true,
-- 	ignore_install = {},
-- 	auto_install = false,
-- })

local fzf = require("fzf-lua")
fzf.setup({
	-- "fzf-vim",
	winopts = {
		border = "solid",
		fullscreen = true,
		preview = {
			border = "solid",
			winopts	= {
				number = false,
			},
		},
	},
})
map("n", "<leader>f", fzf.files)
map("n", "<leader>b", fzf.buffers)
map("n", "<leader>ls", fzf.lsp_document_symbols)
map("n", "<leader>ld", fzf.diagnostics_document)
map("n", "<leader>r", fzf.registers)

-- require("oil").setup({
-- 	confirmation = {
-- 		border = "solid",
-- 	},
-- })
-- map("n", "-", "<CMD>Oil<CR>")

map("n", "<leader>lf", vim.lsp.buf.format)
map("n", "<leader>lr", vim.lsp.buf.rename)

local language_servers = { "lua_ls", "clangd", "rust_analyzer", "svelte", "astro", "ts_ls", "cssls", "zls", "basedpyright", "gopls" }
vim.lsp.enable(language_servers)

-- require("nvim-autopairs").setup()

require("kanagawa").setup()
vim.cmd("colorscheme kanagawa-dragon")
