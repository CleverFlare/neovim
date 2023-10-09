local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync 
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	-- install packer plugin itself
	use("wbthomason/packer.nvim")

	use("nvim-lua/plenary.nvim")

	use({ "catppuccin/nvim", as = "catppuccin" })
	-- use("bluz71/vim-nightfly-guicolors")
	use("christoomey/vim-tmux-navigator")

	use("tpope/vim-surround") -- to surround parts of the code with anything you want
	use("vim-scripts/ReplaceWithRegister") -- to copy something and put it as a replacement for another thing

	use("numToStr/Comment.nvim") -- to comment things easier

	use("nvim-tree/nvim-tree.lua") -- for the tree explorer (CTRL + n)

	use("nvim-tree/nvim-web-devicons") -- for web development icons

	-- for the statusline
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	-- telescope
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })

	-- autocompletion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")

	-- snippets
	use({ "L3MON4D3/LuaSnip", tag = "v2.*", run = "make install_jsregexp" })
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	-- managing and installing lsp servers, linsters, and formatters
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	-- configuring lsp servers
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp")
	use({ "glepnir/lspsaga.nvim", branch = "main" })
	use("jose-elias-alvarez/typescript.nvim")
	use("onsails/lspkind.nvim")

	-- formatting and linting
	use("stevearc/conform.nvim")
	use({ "mfussenegger/nvim-lint", event = { "BufReadPre", "BufNewFile" } })
	use("WhoIsSethDaniel/mason-tool-installer.nvim")

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- auto closing
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	-- git signs plugin
	use("lewis6991/gitsigns.nvim")

	-- codeium AI code assisstant
	use({
		"Exafunction/codeium.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
		end,
	})

	-- startup page
	use({
		"goolord/alpha-nvim",
		config = function()
			require("alpha").setup(require("flare.plugins.dashboard").config)
		end,
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
