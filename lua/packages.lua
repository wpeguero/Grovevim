-- START
Use = require("packer").use
require("packer").startup(function()
	-- Language Server installer
	Use {
	'williamboman/nvim-lsp-installer',
	}
	-- ...
	-- LSP Client
	Use 'neovim/nvim-lspconfig'
	-- BONUS: Customizations over LSP
	-- Show VSCode-esque pictograms
	Use 'onsails/lspkind-nvim'
	-- show various elements of LSP as UI
	Use {'tami5/lspsaga.nvim', requires = {'neovim/nvim-lspconfig'}}
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

end)

-- END
