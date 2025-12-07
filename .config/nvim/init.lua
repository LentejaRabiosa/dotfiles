vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.termguicolors = true
vim.o.wrap = false
vim.o.tabstop = 4 -- the tab key
vim.o.shiftwidth = 4 -- <> operations
vim.o.expandtab = false
vim.o.smartindent = true
vim.o.swapfile = false
vim.o.winborder = "solid"
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("$HOME/.undodir")
vim.o.incsearch = true
vim.o.ignorecase = true

-- vim.diagnostic.config({
-- 	virtual_text = false, -- in line
-- 	virtual_lines = { current_line = true }, -- new lines
-- 	underline = true,
-- })

vim.lsp.config['basedpyright'] = require 'lsp.basedpyright'
vim.lsp.config['rust_analyzer'] = require 'lsp.rust_analyzer'
vim.lsp.config['clangd'] = require 'lsp.clangd'
vim.lsp.enable({ 'basedpyright', 'rust_analyzer', 'clangd' })
