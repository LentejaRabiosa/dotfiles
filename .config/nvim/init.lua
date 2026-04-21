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
    "https://github.com/ibhagwan/fzf-lua.git",
    "https://github.com/webhooked/kanso.nvim.git",
    "https://github.com/stevearc/oil.nvim.git",
    "https://github.com/tpope/vim-fugitive",
})

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

-- THEME: kanso
require("kanso").setup({
    compile = true,
    minimal = true,
    background = {
        dark = os.getenv("THEME") or "zen",
    },
})

vim.cmd("colorscheme kanso")

-- MAPS
local map = vim.keymap.set

map({ 'n', 'v', 'x' }, '<leader>y', '"+y')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d')
map('n', '<leader>2', '<cmd>set tabstop=2 shiftwidth=2<cr>', { noremap = true })
map('n', '<leader>4', '<cmd>set tabstop=4 shiftwidth=4<cr>', { noremap = true })
map('n', '<leader>8', '<cmd>set tabstop=8 shiftwidth=8<cr>', { noremap = true })

map("n", "<leader>f", fzf.files)
map("n", "<leader>b", fzf.buffers)
map("n", "<leader>r", fzf.registers)
map("n", "<leader>/", fzf.lgrep_curbuf)

map("n", "<leader>o", "<cmd>Oil<cr>")
