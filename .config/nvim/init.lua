-- global
vim.g.mapleader = ' '

-- options
-- vim.o.guicursor = '' -- cursor block
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = false
vim.o.signcolumn = 'yes'
vim.o.termguicolors = true
vim.o.wrap = false
vim.o.tabstop = 4 -- the tab key
vim.o.shiftwidth = 4 -- <> operations
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.swapfile = false
vim.o.winborder = 'solid'
vim.o.undofile = true
vim.o.undodir = vim.fn.expand('$HOME/.undodir')
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.listchars= 'tab:> ,trail:·,nbsp:+'
vim.o.list = true

vim.cmd.packadd('nvim.undotree')

vim.pack.add({
    { src = 'https://github.com/saghen/blink.cmp', version = 'tags/v1.10.2' },
    'https://github.com/ibhagwan/fzf-lua',
    'https://github.com/neovim/nvim-lspconfig.git',
    'https://github.com/miikanissi/modus-themes.nvim',
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/tpope/vim-surround',
    'https://github.com/tpope/vim-repeat',
})

require("modus-themes").setup({
    line_nr_column_background = false,
    sign_column_background = false,
})

vim.cmd('colorscheme modus_vivendi')

vim.lsp.enable('rust_analyzer')
vim.lsp.enable('clangd')

-- typst config
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'typst',
    callback = function()
        vim.opt_local.linebreak = true
        vim.opt_local.wrap = true
        -- vim.opt_local.textwidth = 0
        -- vim.opt_local.wrapmargin = 0
    end,
})

-- Auto-populate Neovim quickfix list on diagnostic changes
-- vim.api.nvim_create_autocmd("DiagnosticChanged", {
--   callback = function()
--     vim.diagnostic.setqflist({ open = false })
--   end,
-- })

require('blink.cmp').setup({
    cmdline = { enabled = true },
    completion = {
        ghost_text = { enabled = true },
    },
    sources = {
        default = { 'lsp', 'path' },
        -- default = { 'lsp', 'buffer', 'snippets', 'path' },
    },
    keymap = {
        ['<Tab>'] = { 'select_and_accept', 'fallback' },
    },
    fuzzy = {
        implementation = 'prefer_rust_with_warning',
        prebuilt_binaries = {
            download = true,
        },
    },
})

local fzf = require('fzf-lua')
fzf.setup({'ivy'})

-- MAPS
local map = vim.keymap.set
map('n', '<Space>', '<Nop>')
map('n', '<leader>w', '<cmd>w<cr>')
map('n', '<leader>a', '<cmd>wa<cr>')
map('n', '<leader>q', '<cmd>wqa<cr>')
map({ 'n', 'v', 'x' }, '<leader>y', '"+y')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d')
map('n', '<leader>2', '<cmd>set tabstop=2 shiftwidth=2<cr>', { noremap = true })
map('n', '<leader>4', '<cmd>set tabstop=4 shiftwidth=4<cr>', { noremap = true })
map('n', '<leader>8', '<cmd>set tabstop=8 shiftwidth=8<cr>', { noremap = true })
map('n', '<C-n>', '<cmd>cnext<cr>')
map('n', '<C-p>', '<cmd>cprev<cr>')

map('n', '<leader>f', fzf.files)
map('n', '<leader>g', fzf.git_files)
map('n', '<leader>b', fzf.buffers)
map('n', '<leader>r', fzf.registers)
map('n', '<leader>/', fzf.lgrep_curbuf)
map('n', '<leader>ld', fzf.lsp_document_diagnostics)
map('n', '<leader>lD', fzf.lsp_workspace_diagnostics)
map('n', '<leader>ls', fzf.lsp_document_symbols)
map('n', '<leader>lS', fzf.lsp_workspace_symbols)

map('n', '<leader>s', '<cmd>LspClangdSwitchSourceHeader<cr>')
map('n', '<leader>lc', vim.diagnostic.setqflist)

map('n', '<leader>u', '<cmd>Undotree<cr>')
