vim.g.mapleader = ' '

vim.o.scrolloff = 8
vim.o.guicursor = ''
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes' -- default: yes
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

local map = vim.keymap.set

map("n", "<leader>o", ":update<CR> :source<CR>")
map("n", "<leader>w", ":w<CR>")
map("n", "<leader>a", ":wa<CR>")
map({ 'n', 'v', 'x' }, '<leader>y', '"+y')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d')
map('n', '<leader>2', '<cmd>set tabstop=2 shiftwidth=2<cr>', { noremap = true })
map('n', '<leader>4', '<cmd>set tabstop=4 shiftwidth=4<cr>', { noremap = true })
map('n', '<leader>8', '<cmd>set tabstop=8 shiftwidth=8<cr>', { noremap = true })
map('n', '<leader>lf', vim.lsp.buf.format)

-- vim.diagnostic.config({
--     virtual_text = false, -- in line
--     virtual_lines = { current_line = true }, -- new lines
--     underline = true,
-- })

vim.lsp.config['basedpyright'] = require 'lsp.basedpyright'
vim.lsp.config['rust_analyzer'] = require 'lsp.rust_analyzer'
vim.lsp.config['clangd'] = require 'lsp.clangd'
vim.lsp.config['ts_ls'] = require 'lsp.ts_ls'
vim.lsp.config['svelte'] = require 'lsp.svelte'
vim.lsp.config['cssls'] = require 'lsp.cssls'
vim.lsp.enable({ 'basedpyright', 'rust_analyzer', 'clangd', 'ts_ls', 'svelte', 'cssls' })

local fzf = require("fzf-lua")
fzf.setup({
    winopts = {
        border = "solid",
        fullscreen = true,
        preview = {
            border = "solid",
            winopts = {
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

local ts_parsers = { "svelte", "typescript", "javascript", "html", "css", "cpp", "rust", "astro", "zig", "python", "go" }
for _, parser in ipairs(ts_parsers) do
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { parser },
      callback = function() vim.treesitter.start() end,
    })
end

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

require("kanso").setup({
    compile = true,
    background = {
        dark = "zen",
    },
})
vim.cmd("colorscheme kanso")
