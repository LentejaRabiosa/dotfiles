vim.g.mapleader = ' '

-- vim.o.guicursor = '' -- cursor block
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.signcolumn = 'yes'
vim.o.termguicolors = true
vim.o.wrap = false
vim.o.tabstop = 4 -- the tab key
vim.o.shiftwidth = 4 -- <> operations
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.swapfile = false
vim.o.winborder = 'none'
vim.o.undofile = true
vim.o.undodir = vim.fn.expand('$HOME/.undodir')
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.listchars= 'tab:> ,trail:·,nbsp:+'
vim.o.list = true
vim.opt.fixendofline = true
vim.opt.endofline = true

vim.cmd.packadd('nvim.undotree')
vim.pack.add({
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/tpope/vim-surround',
    'https://github.com/tpope/vim-repeat',
    'https://github.com/tpope/vim-vinegar',
})

function UseFd(cmdarg, cmdcomplete)
    local files = vim.fn.systemlist('fd --type f --hidden -E .git --full-path')

    if cmdarg == nil or cmdarg == "" then
        return files
    end

    local matches = vim.fn.matchfuzzy(files, cmdarg or '')
    return matches
end
vim.o.findfunc = "v:lua.UseFd"

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

local map = vim.keymap.set
map('n', '<Space>', '<Nop>')
map({ 'n', 'v', 'x' }, '<leader>y', '"+y')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d')
map('n', '<C-n>', '<cmd>cnext<cr>')
map('n', '<C-p>', '<cmd>cprev<cr>')
map('n', '<leader>q', '<cmd>copen<cr>')
map('n', '<leader>Q', '<cmd>cclose<cr>')
map('n', '<leader>e', '<cmd>Ex<cr>')
map('n', '<leader>u', '<cmd>Undotree<cr>')
map('n', '<leader>f', ':find ')
map('i', '<C-s>', 'std::', { noremap = true, silent = true })
map('n', '<leader>m', ':make ')
