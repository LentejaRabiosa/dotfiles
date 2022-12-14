local status, packer = pcall(require, "packer")
if not status then
	print("Packer is not installed")
	return
end

-- Reloads Neovim after whenever you save plugins.lua
vim.cmd([[
    augroup packer_user_config
      autocmd!
     autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup END
]])

packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use("nvim-treesitter/nvim-treesitter") -- Treesitter Syntax Highlighting

	-- Comments
	use("numToStr/Comment.nvim")

    -- Themes/Colorshemes
    use("arzg/vim-colors-xcode")
	use("joshdick/onedark.vim")
	use({
    'rose-pine/neovim',
    as = 'rose-pine',
})

	if packer_bootstrap then
		packer.sync()
	end
end)
