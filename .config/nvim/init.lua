-- global
vim.g.mapleader = ' '

-- options
vim.o.guicursor = ''
vim.o.number = true
vim.o.relativenumber = true
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

vim.pack.add({
    { src = 'https://github.com/saghen/blink.cmp', version = 'tags/v1.10.2' },
    'https://github.com/neovim/nvim-lspconfig.git',
    'https://github.com/dmtrKovalenko/fff.nvim',
    'https://github.com/webhooked/kanso.nvim.git',
    'https://github.com/stevearc/oil.nvim.git',
    'https://github.com/tpope/vim-fugitive',
})

vim.lsp.enable('rust_analyzer')

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

require('oil').setup({
    default_file_explorer = true,
    columns = {
        'permissions',
        'size',
        'mtime',
    },
    delete_to_trash = false,
    skip_confirm_for_simple_edits = false,
    prompt_save_on_select_new_entry = true,
    lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = false,
    },
    constrain_cursor = 'editable', -- or 'name'
    view_options = {
        show_hidden = true,
        is_hidden_file = function(name, bufnr)
            local m = name:match('^%.')
            return m ~= nil
        end,
        is_always_hidden = function(name, bufnr)
            return false
        end,
        natural_order = 'fast',
        case_insensitive = false,
        sort = {
            { 'type', 'asc' },
            { 'name', 'asc' },
        },
    },
})

require('fff').setup({
    prompt = '> ',
    layout = {
        height = 0.8,
        width = 0.8,
    },
})

require('kanso').setup({
    compile = true,
    minimal = true,
    background = {
        dark = os.getenv('THEME') or 'zen',
    },
})

vim.cmd('colorscheme kanso')

-- MAPS
local map = vim.keymap.set
map('n', '<leader>w', '<cmd>w<cr>')
map('n', '<leader>a', '<cmd>wa<cr>')
map('n', '<leader>q', '<cmd>wqa<cr>')
map({ 'n', 'v', 'x' }, '<leader>y', '"+y')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d')
map('n', '<leader>2', '<cmd>set tabstop=2 shiftwidth=2<cr>', { noremap = true })
map('n', '<leader>4', '<cmd>set tabstop=4 shiftwidth=4<cr>', { noremap = true })
map('n', '<leader>8', '<cmd>set tabstop=8 shiftwidth=8<cr>', { noremap = true })

map('n', '<leader>f', require('fff').find_files)
map('n', '<leader>/', require('fff').live_grep)

map('n', '<leader>lf', vim.lsp.buf.format)

map('n', '<leader>o', '<cmd>Oil<cr>')
