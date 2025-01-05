local vim = vim

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function ()
                local configs = require("nvim-treesitter.configs")

                configs.setup({
                    sync_install = false,
                    auto_install = true,
                    highlight = { enable = true },
                    -- indent = { enable = true },
                })
            end
        },

        { 'projekt0n/github-nvim-theme', name = 'github-theme' },
        { "rebelot/kanagawa.nvim" },

        {
            "ibhagwan/fzf-lua",
            config = function()
                require("fzf-lua").setup({})
            end
        },

        {
            'saghen/blink.cmp',
            dependencies = 'rafamadriz/friendly-snippets',

            version = '*',

            ---@module 'blink.cmp'
            ---@type blink.cmp.Config
            opts = {
                -- 'default' for mappings similar to built-in completion
                -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
                -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
                -- See the full "keymap" documentation for information on defining your own keymap.
                keymap = {
                    preset = 'none',
                    ['<Enter>'] = { 'accept' , 'fallback' },
                    ['<Tab>'] = { 'select_next', 'fallback' },
                    ['<S-Tab>'] = { 'select_prev', 'fallback' },
                    ['<Esc>'] = { 'cancel', 'fallback' },
                },

                appearance = {
                    use_nvim_cmp_as_default = true,
                    nerd_font_variant = 'mono'
                },

                completion = {
                    menu = {
                        auto_show = function(ctx)
                            return ctx.mode ~= "cmdline" or not vim.tbl_contains({ '/', '?' }, vim.fn.getcmdtype())
                        end,
                    },
                    list = { selection = function(ctx) return ctx.mode == 'cmdline' and 'auto_insert' or 'preselect' end },
                },

                -- Default list of enabled providers defined so that you can extend it
                -- elsewhere in your config, without redefining it, due to `opts_extend`
                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer' },
                },
            },
            opts_extend = { "sources.default" }
        },

        {
            'neovim/nvim-lspconfig',
            dependencies = { 'saghen/blink.cmp' },

            -- local servers = {'ts_ls', 'lua_ls', 'clangd', 'html', 'cssls', 'jsonls', 'rust_analyzer', 'astro', 'mdx_analyzer', 'markdown_oxide'}
            opts = {
                servers = {
                    lua_ls = {},
                    ts_ls = {},
                    clangd = {},
                    html = {},
                    cssls = {},
                    jsonls = {},
                    astro = {},
                }
            },
            config = function(_, opts)
                local lspconfig = require('lspconfig')
                for server, config in pairs(opts.servers) do
                    config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                    lspconfig[server].setup(config)
                end
            end
        },

        {"williamboman/mason.nvim"},
        {'lewis6991/gitsigns.nvim'},
        {"nvim-lua/plenary.nvim" },
        {"sindrets/diffview.nvim"},
        {'nvim-lualine/lualine.nvim'},
        {"folke/trouble.nvim" },
        {'windwp/nvim-ts-autotag'},
        {'numToStr/Comment.nvim'},

        {
            'windwp/nvim-autopairs',
            event = "InsertEnter",
            config = true
            -- use opts = {} for passing setup options
            -- this is equivalent to setup({}) function
        },

        {
            "ThePrimeagen/harpoon",
            branch = "harpoon2",
            dependencies = { "nvim-lua/plenary.nvim" }
        },

        { 'echasnovski/mini.align', version = '*' },
        { "nvimtools/hydra.nvim" },
        -- { "chrisgrieser/nvim-spider", lazy = true },

        {
            "davidmh/mdx.nvim",
            config = true,
            dependencies = {"nvim-treesitter/nvim-treesitter"}
        },

        {'mbbill/undotree'}
    },
})

local Hydra = require("hydra")
local files_hydra = Hydra({
    name = "resize",
    mode = "n",
    config = {
        color = "red",
        invoke_on_body = "true",
    },
    heads = {
            { "h", "<cmd>vertical resize -1<cr>", {                    } },
            { "l", "<cmd>vertical resize +1<cr>", {                    } },
            { "j", "<cmd>resize +1<cr>",          {                    } },
            { "k", "<cmd>resize -1<cr>",          {                    } },
    },
})

require("mason").setup()

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = false,
})

local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Default options
require('github-theme').setup({
    options = {
        -- Compiled file's destination location
        compile_path = vim.fn.stdpath('cache') .. '/github-theme',
        compile_file_suffix = '_compiled', -- Compiled file suffix
        hide_end_of_buffer = true, -- Hide the '~' character at the end of the buffer for a cleaner look
        hide_nc_statusline = true, -- Override the underline style for non-active statuslines
        transparent = false,       -- Disable setting bg (make neovim's background transparent)
        terminal_colors = true,    -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
        dim_inactive = true,      -- Non focused panes set to alternative background
        module_default = true,     -- Default enable value for modules
        styles = {                 -- Style to be applied to different syntax groups
            comments = 'NONE',       -- Value is any valid attr-list value `:help attr-list`
            functions = 'NONE',
            keywords = 'NONE',
            variables = 'NONE',
            conditionals = 'NONE',
            constants = 'NONE',
            numbers = 'NONE',
            operators = 'NONE',
            strings = 'NONE',
            types = 'NONE',
        },
        inverse = {                -- Inverse highlight for different types
            match_paren = false,
            visual = false,
            search = false,
        },
        darken = {                 -- Darken floating windows and sidebar-like windows
            floats = true,
            sidebars = {
                enable = true,
                list = {},             -- Apply dark background to specific windows
            },
        },
        modules = {                -- List of various plugins and additional options
            -- ...
        },
    },
    palettes = {},
    specs = {},
    groups = {},
})
-- vim.cmd('colorscheme github_dark_default')

-- Default options:
require('kanagawa').setup({
    compile = false,             -- enable compiling the colorscheme
    undercurl = true,            -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,         -- do not set background color
    dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
    colors = {                   -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function(colors) -- add/modify highlights
        return {}
    end,
    theme = "dragon",              -- Load "wave" theme when 'background' option is not set
    background = {               -- map the value of 'background' option to a theme
        dark = "dragon",           -- try "dragon" !
        light = "lotus"
    },
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa")

-- local neogit = require('neogit')
-- neogit.setup {}

require('fzf-lua').setup{{'borderless_full'}}

require('Comment').setup{{
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = nil,
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
        ---Line-comment toggle keymap
        line = 'gcc',
        ---Block-comment toggle keymap
        block = 'gbc',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = 'gc',
        ---Block-comment keymap
        block = 'gb',
    },
    ---LHS of extra mappings
    extra = {
        ---Add comment on the line above
        above = 'gcO',
        ---Add comment on the line below
        below = 'gco',
        ---Add comment at the end of line
        eol = 'gcA',
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
    },
    ---Function to call before (un)comment
    pre_hook = nil,
    ---Function to call after (un)comment
    post_hook = nil,
}}

require('gitsigns').setup {
    signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signs_staged = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signs_staged_enable = true,
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        follow_files = true
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
}

require('nvim-ts-autotag').setup({
    opts = {
        -- Defaults
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = true -- Auto close on trailing </
    },
    -- Also override individual filetype configs, these take priority.
    -- Empty by default, useful if one of the "opts" global settings
    -- doesn't work well in a specific filetype
    -- per_filetype = {
    --   ["html"] = {
    --       enable_close = false
    --   }
    -- }
})

require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

require('mini.align').setup()

require("trouble").setup({
    auto_close = true,
    auto_refresh = true,
})

local harpoon = require("harpoon")
-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.g.undotree_WindowLayout = 2
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_DiffAutoOpen = 0
vim.g.undotree_HelpLine = 0
vim.g.undotree_SplitWidth = 60

vim.g.mapleader        = ' '
vim.g.maplocalleader   = ' '
vim.opt.relativenumber = true
vim.opt.number         = true
vim.opt.conceallevel   = 1
vim.opt.showtabline    = 0
vim.opt.smartindent    = true
vim.opt.cindent        = false
vim.opt.autoindent     = false
vim.opt.tabstop        = 4
vim.opt.shiftwidth     = 4
vim.opt.expandtab      = true
vim.opt.undofile       = true
vim.opt.undodir        = vim.fn.expand("~/.undodir")

vim.keymap.set("n", "<leader>ff",       require('fzf-lua').files,                                    { desc = "Fzf Files" })
vim.keymap.set("n", "<leader>fb",       require('fzf-lua').buffers,                                  { desc = "Fzf Buffers" })
vim.keymap.set("n", "<leader>fg",       require('fzf-lua').git_files,                                { desc = "Fzf Git Files" })
vim.keymap.set("n", "<leader>fr",       require('fzf-lua').lsp_references,                           { desc = "Fzf References (LSP)" })
vim.keymap.set("n", "<leader>fds",      require('fzf-lua').lsp_document_symbols,                     { desc = "Fzf Documents Symbols (LSP)" })
vim.keymap.set("n", "<leader>f/",       require('fzf-lua').live_grep,                                { desc = "Fzf Seach In Current Project" })
vim.keymap.set("n", "<leader>td",       "<cmd>Trouble diagnostics toggle<cr>", { desc = "Fzf Seach In Current Project" })
-- vim.keymap.set("n", "<leader>ng",       function() neogit.open()                                end, { desc = "Open Neogit" })
vim.keymap.set("n", "<leader>ha",       function() harpoon:list():add()                         end)
vim.keymap.set("n", "<leader>hh",       function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<leader>1",        function() harpoon:list():select(1)                     end)
vim.keymap.set("n", "<leader>2",        function() harpoon:list():select(2)                     end)
vim.keymap.set("n", "<leader>3",        function() harpoon:list():select(3)                     end)
vim.keymap.set("n", "<leader>4",        function() harpoon:list():select(4)                     end)
vim.keymap.set("n", "<leader>p",        function() harpoon:list():prev()                        end)
vim.keymap.set("n", "<leader>n",        function() harpoon:list():next()                        end)
vim.keymap.set("n", "<leader><leader>", function() files_hydra:activate()                       end, { desc = "Activate files hydra" })
vim.keymap.set("n", "<leader>u",        vim.cmd.UndotreeToggle,                                      { desc = "Toggle Undo Tree" })

