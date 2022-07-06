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

require('autocomplete')
require('_theme')
require('essentials')
require('_lspconfig')
require('packages')
require('_telescope')
require('_treesitter')
