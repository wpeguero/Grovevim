-- ...
-- Do not show current vim mode since it is already shown by Lualine
vim.o.showmode = false

-- enable autowriteall
vim.o.autowriteall = true

-- Show the line numbers
vim.wo.number = true

-- Show chars at the end of line
vim.opt.list = true

-- Enable break indent
vim.o.breakindent = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250

-- Shows signs by Autocompletion plugin
vim.wo.signcolumn = 'yes'

-- Enable termguicolors. Very essential if you want 24-bit RGB color in TUI.
vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone'

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
vim.cmd [[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]]
-- ...

-- Auto Bracket Pairing
vim.g.AutoPairs = {
	['('] = ')',
	['['] = ']',
	['{'] = '}',
	["'"] = "'",
	['"'] = '"',
	['`'] = '`',
	['<'] = '>',
}

-- ...

-- Status Bar
require('lualine').setup({
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ' '},
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = false,
	},
	sections = {
		lualine_a = {
			'mode'
		},
		lualine_b = {
			'branch',
			'diff',
			'diagnostics'
		},
		lualine_c = {
			{ 'filename', path = 1 },
			'lsp_progress',
		},
		lualine_x = {
			'encoding',
			'fileformat',
			'filetype',
		},
		lualine_y = {
			'progress',
		},
		lualine_z = {
			'location',
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	extensions = {}
})

-- ...

-- Set folding

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
