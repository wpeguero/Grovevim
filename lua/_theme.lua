-- START
require('packages')

-- Colorscheme
vim.opt.background = "dark"
require("onedark").setup({
	style = "darker",
	transparent = false,
	term_colors = true,
	ending_tildes = false,
	cmp_itemkind_reverse = false,
	-- Toggle theme style --
	toggle_style = '<leader>ts',
	toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'},

	-- Change code style --
	-- Options: italic, bold, underline, none
	code_style = {
		comments = 'italic',
		keywords = 'none',
		functions = 'none',
		strings = 'none',
		variables = 'none'
	},

	-- Custom highlights
	colors = {},
	highlights = {},

	-- Plugins Config --
	diagnostics = {
		darker = true,
		undercurl = true,
		background = true,
	},
})
require('onedark').load()
-- END