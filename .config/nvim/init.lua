-- global
vim.g.mapleader = ' '

-- options
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

-- LSP
local lsp_servers = {
    'basedpyright',
    'rust_analyzer',
    'clangd',
    'ts_ls',
    'svelte',
    'cssls',
    'tinymist',
}
vim.lsp.enable(lsp_servers)

-- typst config
vim.api.nvim_create_autocmd("FileType", {
    pattern = "typst",
    callback = function()
        vim.opt_local.linebreak = true
        vim.opt_local.wrap = true
        -- vim.opt_local.textwidth = 0
        -- vim.opt_local.wrapmargin = 0
    end,
})

-- treesitter
local ts_parsers = {
    "svelte",
    "typescript",
    "javascript",
    "html",
    "css",
    "cpp",
    "rust",
    "astro",
    "zig",
    "python",
    "go",
    "typst",
    "markdown",
}

for _, parser in ipairs(ts_parsers) do
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { parser },
      callback = function() vim.treesitter.start() end,
    })
end

-- PLUGIN: fzf-lua
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

-- PLUGIN: oil
require("oil").setup({
    default_file_explorer = true,
    columns = {
        "permissions",
        "size",
        "mtime",
    },
    delete_to_trash = false,
    skip_confirm_for_simple_edits = false,
    prompt_save_on_select_new_entry = true,
    lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = false,
    },
    constrain_cursor = "editable", -- or "name"
    view_options = {
        show_hidden = true,
        is_hidden_file = function(name, bufnr)
            local m = name:match("^%.")
            return m ~= nil
        end,
        is_always_hidden = function(name, bufnr)
            return false
        end,
        natural_order = "fast",
        case_insensitive = false,
        sort = {
            { "type", "asc" },
            { "name", "asc" },
        },
    },
})

-- PLUGIN: flash
local flash = require('flash')
flash.setup({
    modes = {
        search = {
            enabled = true
        }
    }
})

-- PLUGIN: blink.cmp
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

-- THEME: kanso
require("kanso").setup({
    compile = true,
    background = {
        dark = os.getenv("THEME") or "zen",
    },
})

vim.cmd("colorscheme kanso")

-- MAPS
local map = vim.keymap.set

map("n", "<leader>w", ":w<CR>")
map("n", "<leader>a", ":wa<CR>")
map({ 'n', 'v', 'x' }, '<leader>y', '"+y')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d')
map('n', '<leader>2', '<cmd>set tabstop=2 shiftwidth=2<cr>', { noremap = true })
map('n', '<leader>4', '<cmd>set tabstop=4 shiftwidth=4<cr>', { noremap = true })
map('n', '<leader>8', '<cmd>set tabstop=8 shiftwidth=8<cr>', { noremap = true })

map("n", "<leader>f", fzf.files)
map("n", "<leader>b", fzf.buffers)
map("n", "<leader>ls", fzf.lsp_document_symbols)
map("n", "<leader>ld", fzf.diagnostics_document)
map("n", "<leader>r", fzf.registers)

map('n', '<leader>o', '<cmd>Oil<cr>')

map('n', '<leader>s', flash.toggle)
