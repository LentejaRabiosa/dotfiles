local vim = vim

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
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
            config = function()
                local configs = require("nvim-treesitter.configs")

                configs.setup({
                    sync_install = false,
                    auto_install = true,
                    highlight = { enable = true },
                })
            end
        },

        {
            "folke/flash.nvim",
            event = "VeryLazy",
            ---@type Flash.Config
            opts = {},
            -- stylua: ignore
            keys = {
                { "<leader>s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
                { "<leader>S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
                { "<leader>r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
                { "<leader>R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
                { "<c-s>",     mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
            },
        },

        { "rebelot/kanagawa.nvim" },

        {
            "ibhagwan/fzf-lua",
            config = function()
                require("fzf-lua").setup({
                    winopts = {
                        border = "none",
                        fullscreen = "true",
                        preview = {
                            border = "none",
                            scrollbar = "none",
                        },
                    },
                    keymap = {
                        fzf = {
                            ["ctrl-q"] = "select-all+accept",
                        },
                    },
                })
            end
        },

        {
            'L3MON4D3/LuaSnip',
            -- dependencies = { 'rafamadriz/friendly-snippets' },
            config = function()
                require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })
                require("luasnip").filetype_extend("mdx", { "plaintex" })
                require("luasnip").filetype_extend("markdown", { "plaintex" })
            end
        },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        {
            'hrsh7th/nvim-cmp',
            config = function()
                local cmp = require 'cmp'
                local luasnip = require("luasnip")
                cmp.setup({
                    snippet = {
                        -- REQUIRED - you must specify a snippet engine
                        expand = function(args)
                            luasnip.lsp_expand(args.body) -- For `luasnip` users.
                        end,
                    },
                    window = {
                    },
                    mapping = cmp.mapping.preset.insert({
                        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-f>'] = cmp.mapping.scroll_docs(4),
                        ['<C-Space>'] = cmp.mapping.complete(),
                        ['<C-e>'] = cmp.mapping.abort(),
                        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    }),
                    sources = cmp.config.sources({
                        { name = 'nvim_lsp' },
                        { name = 'luasnip' }, -- For luasnip users.
                    }, {
                        { name = 'buffer' },
                    })
                })

                cmp.setup.cmdline({ '/', '?' }, {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = {
                        { name = 'buffer' }
                    }
                })

                cmp.setup.cmdline(':', {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources({
                        { name = 'path' }
                    }, {
                        { name = 'cmdline' }
                    }),
                    matching = { disallow_symbol_nonprefix_matching = false }
                })
            end
        },

        {
            'neovim/nvim-lspconfig',
            opts = {
                servers = {
                    lua_ls = {},
                    ts_ls = {},
                    clangd = {},
                    html = {},
                    cssls = {},
                    jsonls = {},
                    astro = {},
                    svelte = {},
                    rust_analyzer = {},
                    tailwindcss = {},
                    mdx_analyzer = {},
                    pyright = {},
                }
            },
            config = function(_, opts)
                local lspconfig = require('lspconfig')
                for server, config in pairs(opts.servers) do
                    config.capabilities = require('cmp_nvim_lsp').default_capabilities(config.capabilities)
                    lspconfig[server].setup(config)
                end
            end
        },

        { "williamboman/mason.nvim" },
        { 'lewis6991/gitsigns.nvim' },
        { 'tpope/vim-fugitive' },
        { "nvim-lua/plenary.nvim" },
        -- { "sindrets/diffview.nvim" },
        { 'nvim-lualine/lualine.nvim' },
        { "folke/trouble.nvim" },
        { 'windwp/nvim-ts-autotag' },
        { 'numToStr/Comment.nvim' },

        {
            'windwp/nvim-autopairs',
            event = "InsertEnter",
            config = true
            -- use opts = {} for passing setup options
            -- this is equivalent to setup({}) function
        },

        -- { 'echasnovski/mini.align', version = '*' },
        { "nvimtools/hydra.nvim" },
        { "chrisgrieser/nvim-spider", lazy = true },

        {
            "davidmh/mdx.nvim",
            config = true,
            dependencies = {"nvim-treesitter/nvim-treesitter"}
        },

        { 'mbbill/undotree' },

        {
            "epwalsh/obsidian.nvim",
            version = "*",	-- recommended, use latest release instead of latest commit
            lazy = true,
            ft = "markdown",
            -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
            -- event = {
            --	 -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
            --	 -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
            --	 -- refer to `:h file-pattern` for more examples
            --	 "BufReadPre path/to/my-vault/*.md",
            --	 "BufNewFile path/to/my-vault/*.md",
            -- },
            dependencies = {
                -- Required.
                "nvim-lua/plenary.nvim",

                -- see below for full list of optional dependencies 👇
            },
            opts = {
                workspaces = {
                    {
                        name = "second-brain",
                        path = "~/second-brain",
                    },
                },

                -- see below for full list of options 👇
            },
        },


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
        { "h", "<cmd>vertical resize -1<cr>", {} },
        { "l", "<cmd>vertical resize +1<cr>", {} },
        { "j", "<cmd>resize +1<cr>",          {} },
        { "k", "<cmd>resize -1<cr>",          {} },
    },
})

require("mason").setup()

vim.diagnostic.config({
    virtual_text = {
        -- prefix = "·",
        spacing = 2,
        format = function(diagnostic)
            return string.format("%s", diagnostic.message)
        end,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN]  = "W",
            [vim.diagnostic.severity.INFO]  = "I",
            [vim.diagnostic.severity.HINT]  = "H",
        }
    },
    underline = true,
    update_in_insert = true,
    severity_sort = true,
})

require('kanagawa').setup({
    compile = false,  -- enable compiling the colorscheme
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,   -- do not set background color
    dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
    terminalColors = true, -- define vim.g.terminal_color_{0,17}
    colors = {             -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function(colors) -- add/modify highlights
        return {}
    end,
    theme = "dragon",    -- Load "wave" theme when 'background' option is not set
    background = {       -- map the value of 'background' option to a theme
        dark = "dragon", -- try "dragon" !
        light = "lotus"
    },
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa")

-- require('fzf-lua').setup({ { "borderless_full" }, winopts = { fullscreen = true } })
-- local config = require("fzf-lua.config")
-- local actions = require("trouble.sources.fzf").actions
-- config.defaults.actions.files["ctrl-t"] = actions.open

require('Comment').setup { {
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
} }

require('gitsigns').setup {
    signs                        = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signs_staged                 = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signs_staged_enable          = true,
    signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir                 = {
        follow_files = true
    },
    auto_attach                  = true,
    attach_to_untracked          = false,
    current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil,   -- Use default
    max_file_length              = 40000, -- Disable if file is longer than this (in lines)
    preview_config               = {
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
        enable_close = true,         -- Auto close tags
        enable_rename = true,        -- Auto rename pairs of tags
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
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
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
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

require("trouble").setup({
    auto_close = true,
    auto_refresh = true,
    modes = {
        diagnostics = {
        },
    }
})

-- Create an autocommand group for Markdown and MDX settings
vim.api.nvim_create_augroup("MarkdownMaxWidth", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "MarkdownMaxWidth",
    pattern = { "markdown", "mdx" },
    callback = function()
        vim.opt_local.textwidth = 80  -- Set maximum line width to 80
        vim.opt_local.wrap = false  -- Disable line wrapping
    end,
})

vim.g.undotree_WindowLayout       = 2
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_DiffAutoOpen       = 0
vim.g.undotree_HelpLine           = 0
vim.g.undotree_SplitWidth         = 60
vim.g.undotree_DiffpanelHeight    = 20

vim.g.mapleader                   = ' '
vim.g.maplocalleader              = ' '
vim.opt.relativenumber            = true
vim.opt.number                    = true
vim.opt.conceallevel              = 1
vim.opt.showtabline               = 0
vim.opt.smartindent               = true
vim.opt.cindent                   = false
vim.opt.autoindent                = false
vim.opt.tabstop                   = 4
vim.opt.shiftwidth                = 4
vim.opt.expandtab                 = true
vim.opt.undofile                  = true
vim.opt.undodir                   = vim.fn.expand("~/.undodir")
vim.opt.textwidth                 = 80
vim.opt.colorcolumn               = "80,120"

vim.opt.list                      = false
vim.opt.listchars                 = {
    space = "·",
    tab = "▸ ",
    trail = "•",
    extends = "▶",
    precedes = "◀",
    nbsp = "␣",
}

vim.keymap.set("n", "<leader>ce", ":set expandtab!<cr>", { desc = "Toggle Expand Tab" })
vim.keymap.set("n", "<leader>ct", ":set tabstop=", { desc = "Set custom tabstop" })
vim.keymap.set("n", "<leader>cs", ":set shiftwidth=", { desc = "Set custom shiftwidth" })
vim.keymap.set("n", "<leader>cl", ":set list!<cr>", { desc = "Toggle whispace" })

vim.keymap.set("n", "<leader>ff", require('fzf-lua').files, { desc = "Fzf Files" })
vim.keymap.set("n", "<leader>fb", require('fzf-lua').buffers, { desc = "Fzf Buffers" })
vim.keymap.set("n", "<leader>ft", require('fzf-lua').tabs, { desc = "Fzf Tabs" })
vim.keymap.set("n", "<leader>fq", require('fzf-lua').quickfix, { desc = "Fzf Quickfix" })
vim.keymap.set("n", "<leader>fg", require('fzf-lua').git_files, { desc = "Fzf Git Files" })
vim.keymap.set("n", "<leader>fr", require('fzf-lua').lsp_references, { desc = "Fzf References (LSP)" })
vim.keymap.set("n", "<leader>fy", require('fzf-lua').registers, { desc = "Fzf Registers" })
vim.keymap.set("n", "<leader>fs", require('fzf-lua').lsp_document_symbols, { desc = "Fzf Documents Symbols (LSP)" })
vim.keymap.set("n", "<leader>f/", require('fzf-lua').lgrep_curbuf, { desc = "Fzf Live Grep Current Buffer" })
vim.keymap.set("n", "<leader>f&", require('fzf-lua').live_grep, { desc = "Fzf Live Grep Current Project" })

vim.keymap.set("n", "<leader>td", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble Diagnostics Toggle" })
vim.keymap.set("n", "<leader>tr", "<cmd>Trouble diagnostics refresh<cr>", { desc = "Trouble Diagnostics Refresh" })
vim.keymap.set("n", "<leader>tn", "<cmd>Trouble diagnostics next<cr><cmd>Trouble diagnostics jump<cr>", { desc = "Trouble Diagnostics Refresh" })
vim.keymap.set("n", "<leader>tp", "<cmd>Trouble diagnostics prev<cr><cmd>Trouble diagnostics jump<cr>", { desc = "Trouble Diagnostics Refresh" })

vim.keymap.set("n", "<leader><leader>", function() files_hydra:activate() end, { desc = "Activate files hydra" })
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undo Tree" })
vim.keymap.set({ "n", "o", "x" }, "<leader>w", "<cmd>lua require('spider').motion('w')<CR>")
vim.keymap.set({ "n", "o", "x" }, "<leader>e", "<cmd>lua require('spider').motion('e')<CR>")
vim.keymap.set({ "n", "o", "x" }, "<leader>b", "<cmd>lua require('spider').motion('b')<CR>")

vim.keymap.set("n", "<leader>qo", "<cmd>copen<cr>", { desc = "Open the quickfix list" });
vim.keymap.set("n", "<leader>qc", "<cmd>cclose<cr>", { desc = "Close the quickfix list" });
vim.keymap.set("n", "<leader>qn", "<cmd>cn<cr>", { desc = "Next quickfix list item" });
vim.keymap.set("n", "<leader>qp", "<cmd>cp<cr>", { desc = "Previous quickfix list item" });

vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'LSP Rename' })

vim.keymap.set({"i"}, "<C-K>", function() require('luasnip').expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() require('luasnip').jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() require('luasnip').jump(-1) end, {silent = true})

vim.keymap.set('n', '-', ':Ex<cr>', { desc = 'Open file explorer' })
