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
map({ 'n', 'v', 'x' }, '<leader>y', '"+y')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d')

vim.pack.add({
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/lervag/vimtex" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
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

vim.cmd('filetype plugin indent on')
vim.g.vimtex_view_method = "zathura"

local ls = require("luasnip")
ls.config.set_config({
	enable_autosnippets = true,
	update_events = "TextChanged,TextChangedI",
	store_selection_keys = "<C-K>",
})
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
map({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
map({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
map({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })
map({ "i", "s" }, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

map("n", "<leader>lf", vim.lsp.buf.format)
map("n", "<leader>lr", vim.lsp.buf.rename)
vim.lsp.enable({ "lua_ls", "clangd", "rust_analyzer", "svelte", "astro", "ts_ls" })
vim.cmd("set completeopt+=noselect")

require("kanagawa").setup()
vim.cmd("colorscheme kanagawa-dragon")
