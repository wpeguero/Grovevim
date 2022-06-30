-- START
require('essentials')
require('packages')

-- ...
--Initial Settings for LSP
-- ...

require("nvim-lsp-installer").setup {
	automatic_installation = true
}
local lspconfig = require("lspconfig")

-- ...
-- Setting the servers
-- ...

local servers = {
	"bashls",
	"jedi_language_server",
	"sumneko_lua",
	"html",
	"clangd",
	"vimls",
	"emmet_ls",
}

-- ...
-- Mappings
-- ...

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- ========== KEYMAPS ==========
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
	-- Floating terminal
	-- NOTE: use `vim.cmd` since `buf_set_keymap` is not working with `tnoremap...`
	vim.cmd [[
	nnoremap <silent> <A-d> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>
	tnoremap <silent> <A-d> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>
	]]
end

-- ...

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- ...
-- Configuring Servers
-- ...

require 'lspconfig'.sumneko_lua.setup {
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

-- ...

lspconfig.jedi_language_server.setup {}

-- ...

lspconfig.bashls.setup {}

-- ...

for _, name in pairs(servers) do
	lspconfig[name].setup { on_attach = on_attach }
end


-- END