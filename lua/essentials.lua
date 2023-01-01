-- ...
-- Do not show current vim mode since it is already shown by Lualine
vim.o.showmode = false

-- Remove the use of mouse
vim.opt.mouse = ""

-- enable omnifunc
vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

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
-- Directory Explorer
-- ...

vim.g.netrw_liststyle = 3

vim.g.netrw_banner = 0 --removes the banner from the directory explorer




-- ...

-- Auto Bracket Pairing
vim.g.AutoPairs = {
	['('] = ')',
	['['] = ']',
	['{'] = '}',
	["'"] = "'",
	['"'] = '"',
	['`'] = '`',
}

-- ...

-- Set folding

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
