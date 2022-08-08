-- Setting up the Packer for Lazy Loading
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute(
	'!git clone https://github.com/wbthomason/packer.nvim ' .. install_path
	)
end

-- Setting up the lazy loader
vim.cmd [[
augroup Packer
	autocmd!
	autocmd BufWritePost init.lua PackerCompile
augroup end
]]

require('packages')
require('essentials')
require('_lualine')
require('autocomplete')
require('_blankline')
require('_theme')
require('_lspconfig')
require('_lspcalightbulb')
require('_telescope')
require('_treesitter')

