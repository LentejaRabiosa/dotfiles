vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.termguicolors = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.swapfile = false
vim.o.winborder = "solid"
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("$HOME/.undodir")
vim.o.incsearch = true
vim.o.smartindent = true
vim.o.ignorecase = true
-- vim.o.textwidth = 80

local map = vim.keymap.set

map("n", "<leader>o", ":update<CR> :source<CR>")
map({ 'n', 'v', 'x' }, '<leader>y', '"+y')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d')

vim.pack.add({
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/lervag/vimtex" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },

	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path" },
	{ src = "https://github.com/hrsh7th/cmp-cmdline" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
})

require "nvim-treesitter.configs".setup({
	ensure_installed = { "svelte", "typescript", "javascript", "cpp", "rust", "astro" },
	highlight = { enable = true },
	modules = {},
	sync_install = true,
	ignore_install = {},
	auto_install = false,
})

local fzf = require("fzf-lua")
fzf.setup({
	"fzf-vim",
	winopts = {
		border = "solid",
	},
})
map("n", "<leader>f", fzf.files)
map("n", "<leader>b", fzf.buffers)
map("n", "<leader>ls", fzf.lsp_document_symbols)
map("n", "<leader>ld", fzf.diagnostics_document)
map("n", "<leader>r", fzf.registers)

require("oil").setup({
	confirmation = {
		border = "solid",
	},
})
map("n", "-", "<CMD>Oil<CR>")

vim.cmd('filetype plugin indent on')
vim.g.vimtex_view_method = "zathura"

local ls = require("luasnip")
ls.config.set_config({
	enable_autosnippets = true,
	update_events = "TextChanged,TextChangedI",
	store_selection_keys = "<C-K>",
})
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
map({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
map({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
map({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })
map({ "i", "s" }, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

map("n", "<leader>lf", vim.lsp.buf.format)
map("n", "<leader>lr", vim.lsp.buf.rename)

local language_servers = { "lua_ls", "clangd", "rust_analyzer", "svelte", "astro", "ts_ls" }
vim.lsp.enable(language_servers)

local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
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
local capabilities = require('cmp_nvim_lsp').default_capabilities()
for _, server in pairs(language_servers) do
	require('lspconfig')[server].setup {
		capabilities = capabilities
	}
end
cmp.event:on(
	'confirm_done',
	require('nvim-autopairs.completion.cmp').on_confirm_done()
)

require("nvim-autopairs").setup()

require("kanagawa").setup()
vim.cmd("colorscheme kanagawa-dragon")
