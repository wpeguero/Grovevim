-- START
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

Use = require("packer").use
require("packer").startup(function(Use)
	-- Package Manager
	Use 'wbthomason/packer.nvim'
	-- ...
	-- LSP Client
	Use 'neovim/nvim-lspconfig'
	-- BONUS: Customizations over LSP
	-- Show VSCode-esque pictograms
	-- Use 'onsails/lspkind-nvim'
	-- show various elements of LSP as UI
	-- Use {'tami5/lspsaga.nvim', requires = {'neovim/nvim-lspconfig'}}
	-- ...
	-- Autocompletion plugin
	Use {
		'hrsh7th/cmp-nvim-lsp',
		requires = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/nvim-cmp',
		}
	}

	-- ...
	-- Code Action Lightbulb
	Use { 'kosayoda/nvim-lightbulb' }

	-- ...
	-- Unicode Characters
	Use {'chrisbra/unicode.vim'}

	-- ...
	-- snippets
	Use {
		'hrsh7th/cmp-vsnip',
		requires = {
			'hrsh7th/vim-vsnip',
			'rafamadriz/friendly-snippets',
			'hrsh7th/nvim-cmp',
		}
	}

	Use {
		'L3MON4D3/LuaSnip'
	}

	-- ...
	-- bracket autocompletion
	Use 'vim-scripts/auto-pairs-gentle'

	-- ...
	-- Fancier statusline
	Use {
		'nvim-lualine/lualine.nvim',
		requires = {
			'kyazdani42/nvim-web-devicons',
			'arkav/lualine-lsp-progress',
		}
	}
	-- ...
	-- Fast incremental parsing library
	Use 'nvim-treesitter/nvim-treesitter'

	-- ...
	-- Beautiful colorscheme
	Use "navarasu/onedark.nvim"

	-- ...
	-- Telescope for Neovim
	Use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	Use { "nvim-telescope/telescope-file-browser.nvim" }

	Use { "nvim-telescope/telescope-ui-select.nvim" }

	-- ...
	-- Indent lines
	Use {"lukas-reineke/indent-blankline.nvim"}

	if packer_bootstrap then
		require('packer').sync()
	end

end)

-- END
