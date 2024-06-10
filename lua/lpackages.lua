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
	{
		'neovim/nvim-lspconfig',
	},
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
	-- VimTex
	{
		  "lervag/vimtex",
		  lazy = false,     -- we don't want to lazy load VimTeX
		  -- tag = "v2.15", -- uncomment to pin to a specific release
		  init = function()
			    -- VimTeX configuration goes here, e.g.
			    vim.g.vimtex_view_method = "zathura"
		  end
	},
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
	'L3MON4D3/LuaSnip',
	'rafamadriz/friendly-snippets',

	-- ...
	-- bracket autocompletion
	'vim-scripts/auto-pairs-gentle',

	-- ...
	-- Fancier statusline
	'nvim-lualine/lualine.nvim',
	'nvim-tree/nvim-web-devicons',
	'arkav/lualine-lsp-progress',
	-- ...
	-- Fast incremental parsing library
	'nvim-treesitter/nvim-treesitter',
	-- ...
	-- Portable package manager for LSP servers, DAP servers, linters, and formatters
	-- Mason.nvim
	-- {'williamboman/mason.nvim', build = ":MasonUpdate"},
	-- ...
	-- Beautiful colorscheme
	"navarasu/onedark.nvim",
	{"catppuccin/nvim", name = "catppuccin", priority = 1000},
	"rebelot/kanagawa.nvim",
	{"folke/tokyonight.nvim", name = "Night"},
	"LunarVim/onedarker.nvim",

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

	-- Gitsigns
	{"lewis6991/gitsigns.nvim"},

	{
		"folke/trouble.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	}
})
