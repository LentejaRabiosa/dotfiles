vim.g.mapleader = ' '

-- vim.o.guicursor = '' -- cursor block
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.tabstop = 4 -- the tab key
vim.opt.shiftwidth = 4 -- <> operations
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.winborder = 'none'
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('$HOME/.undodir')
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.listchars= 'tab:> ,trail:·,nbsp:+'
vim.opt.list = true
vim.opt.grepprg = 'rg --vimgrep'
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
vim.opt.findfunc = "v:lua.UseFd"

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
map('i', '<C-s>', 'std::', { noremap = true, silent = true })
map('n', '<leader>f', ':find ')
map('n', '<leader>m', ':make ')
map('n', '<leader>g', ':grep ')
