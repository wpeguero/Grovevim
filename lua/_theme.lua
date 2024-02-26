-- START
require('lpackages')

-- Colorscheme
vim.opt.background = "dark"
require("onedark").setup({
	style = "deep",
	transparent = false,
	term_colors = true,
	ending_tildes = false,
	cmp_itemkind_reverse = false,
	-- Toggle theme style --
	toggle_style = "<leader>ts",
	toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'},

	-- Change code style --
	-- Options: italic, bold, underline, none
	code_style = {
		comments = 'italic',
		keywords = 'none',
		functions = 'bold',
		strings = 'none',
		variables = 'none'
	},

	-- Custom highlights
	colors = {},
	highlights = {
	},

	-- Plugins Config --
	diagnostics = {
		darker = true,
		undercurl = true,
		background = true,
	},
})

require("catppuccin").setup{
	color_overrides = {
		mocha = {
			base = "#000000",
			mantle = "#000000",
			crust = "#000000",
		}
	}
}

require("tokyonight").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
	light_style = "day", -- The theme is used when the background is set to light
	transparent = false, -- Enable this to disable setting the background color
	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
	styles = {
		    -- Style to be applied to different syntax groups
		    -- Value is any valid attr-list value for `:help nvim_set_hl`
		    comments = { italic = true },
		    keywords = { italic = true },
		    functions = {},
		    variables = {},
		    -- Background styles. Can be "dark", "transparent" or "normal"
		    sidebars = "dark", -- style for sidebars, see below
		    floats = "dark", -- style for floating windows
	  },
	sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
	day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
	hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
	dim_inactive = false, -- dims inactive windows
	lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

	-- You can override specific color groups to use other groups or a hex color
	-- function will be called with a ColorScheme table
	-- @param colors ColorScheme
	on_colors = function(colors)
		colors.bg = "#000000"
	  end,

	  -- You can override specific highlights to use other groups or a hex color
	  -- function will be called with a Highlights and ColorScheme table
	  -- @param highlights Highlights
	  -- @param colors ColorScheme
	on_highlights = function(highlights, colors) end,
})
--vim.cmd("colorscheme catppuccin-mocha")
require('onedark').load()
--vim.cmd('colorscheme tokyonight-night')
-- END
