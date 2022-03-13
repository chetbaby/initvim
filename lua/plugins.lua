vim.cmd("packadd packer.nvim")

-- PROTECTED CALL
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end
-- RELOAD WHENEVER plugins.lua IS SAVED
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])
-- PACKER POPUP WINDOW
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

function Get_config(name)
	return string.format('require("%s")', name)
end

return packer.startup(function()
	use("wbthomason/packer.nvim")

	-- COLOR SCHEMES
	use("lifepillar/vim-gruvbox8")
	use("morhetz/gruvbox")

	-- GIT
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")
	use("tommcdo/vim-fugitive-blame-ext") -- shows commit msg
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		event = "BufReadPre",
		config = function()
			require("config/gitsigns")
		end,
	})

	-- BUFFERLINE/LUALINE/NOTIFY/SIDEBAR/STARTIFY/PROJECT
	use("tweekmonster/startuptime.vim")
	use({
		"akinsho/nvim-bufferline.lua",
		requires = "kyazdani42/nvim-web-devicons",
		event = "BufReadPre",
		config = function()
			require("config/bufferline")
		end,
	})
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("config/lualine")
		end,
		event = "VimEnter",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use({
		"rcarriga/nvim-notify", -- don't know how to use this
		config = function()
			require("config/notify")
		end,
	})

	-- NVIM-TREE
	use({
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("config/nvim-tree")
		end,
		requires = { { "kyazdani42/nvim-web-devicons" } },
	})

	-- FUNCTIONALITIES
	use({
		"Pocco81/AutoSave.nvim",
		config = function()
			require("config/autosave")
		end,
	})
	use("machakann/vim-highlightedyank")
	use("tpope/vim-commentary")
	use("tpope/vim-eunuch")
	use("vim-scripts/restore_view.vim")
	use("qpkorr/vim-bufkill")
	use("Yggdroot/indentLine")
	use({
		"norcalli/nvim-colorizer.lua",
		event = "BufReadPre",
		config = function()
			require("config/colorizer")
		end,
	})

	-- TERMINAL
	use({
		"akinsho/nvim-toggleterm.lua",
		keys = { "<C-y>", "<leader>fl", "<leader>gt" },
		config = function()
			require("config/toggleterm")
		end,
	})

	-- TAG, PAIRS
	use("alvan/vim-closetag")
	use("AndrewRadev/tagalong.vim")
	use("jiangmiao/auto-pairs")
	use("tpope/vim-surround")
	use("Valloric/MatchTagAlways")
	use("luochen1990/rainbow")

	-- TELESCOPE
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
		config = function()
			require("config/telescope")
		end,
	})

	-- FZF
	use({
		"ibhagwan/fzf-lua",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("config/fzf-lua")
		end,
	})

	-- LSP
	use({ "neoclide/coc.nvim", branch = "release" })
	use({
		"folke/trouble.nvim",
		requires = { { "kyazdani42/nvim-web-devicons" } },
		config = function()
			require("config/trouble")
		end,
	})
	use({
		"ThePrimeagen/harpoon",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("config/harpoon")
		end,
	})
end)
