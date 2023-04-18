-- START
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- LSP Client
	'neovim/nvim-lspconfig',
	-- BONUS: Customizations over LSP
	-- Show VSCode-esque pictograms
	-- Use 'onsails/lspkind-nvim'
	-- show various elements of LSP as UI
	-- Use {'tami5/lspsaga.nvim', requires = {'neovim/nvim-lspconfig'}}
	-- ...
	-- Autocompletion plugin
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/nvim-cmp',
	-- ...
	-- Code Action Lightbulb
	{ 'kosayoda/nvim-lightbulb' },

	-- ...
	-- Unicode Characters
	{'chrisbra/unicode.vim'},

	-- ...
	-- snippets
	'hrsh7th/cmp-vsnip',
	'hrsh7th/vim-vsnip',
	'rafamadriz/friendly-snippets',
	'hrsh7th/nvim-cmp',
	'L3MON4D3/LuaSnip',

	-- ...
	-- bracket autocompletion
	'vim-scripts/auto-pairs-gentle',

	-- ...
	-- Fancier statusline
	'nvim-lualine/lualine.nvim',
	'kyazdani42/nvim-web-devicons',
	'arkav/lualine-lsp-progress',
	-- ...
	-- Fast incremental parsing library
	'nvim-treesitter/nvim-treesitter',
	-- ...
	-- Beautiful colorscheme
	-- "navarasu/onedark.nvim",
	-- {"rose-pine/nvim", name = 'rose-pine'},
	{"folke/tokyonight.nvim", name = "Night"},
	-- ...
	-- Telescope for Neovim
	'nvim-telescope/telescope.nvim',
	'nvim-lua/plenary.nvim',

	{ "nvim-telescope/telescope-file-browser.nvim" },

	{ "nvim-telescope/telescope-ui-select.nvim" },

	-- ...
	-- Indent lines
	{"lukas-reineke/indent-blankline.nvim"},

	{
		"akinsho/toggleterm.nvim",
		version = '*',
		opts = {direction='float'}
	},

})
