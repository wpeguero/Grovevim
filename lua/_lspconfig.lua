-- START

-- ...
-- Change Diagnostic Symbols
-- ...

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- ...
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- ...
local opts = { noremap = true, silent = true, callback = vim.lsp.buf.references}
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { unpack(opts), desc = "Open window containing the error or diagnosis." })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { unpack(opts), desc = "Go to the previous error." })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { unpack(opts), desc = "Go to the next error." })
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { unpack(opts), desc = "Open a list of diagnoses in new buffer." })

-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 150

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr, callback = vim.lsp.buf.references }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { unpack(bufopts), desc = "Go to declaration." })
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { unpack(bufopts), desc = "Go to definition." })
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, { unpack(bufopts), desc = "Get definition." })
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { unpack(bufopts), desc = "Implementation" })
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { unpack(bufopts), desc = "Signature help." })
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { unpack(bufopts), desc = "Add workspace folder." })
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { unpack(bufopts), desc = "Remove workspace folder." })
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, { unpack(bufopts), desc = "List workspace folders." })
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, { unpack(bufopts), desc = "Type definition." })
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { unpack(bufopts), desc = "Renamee everywhere." })
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { unpack(bufopts), desc = "Use code action." })
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, { unpack(bufopts), desc = "Obtain references" })
	vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, { unpack(bufopts), desc = "Format the entire document" })
end

-- ...
-- Setting the servers
-- ...

local lspconfig = require("lspconfig")

lspconfig.util.default_config = vim.tbl_extend(
	"force",
	lspconfig.util.default_config,
	{
		on_attach = on_attach
	}
)

local servers = {
	"bashls",
	"pylsp",
	"sumneko_lua",
	"html",
	"clangd",
	"vimls",
	"emmet_ls",
	"julials",
	"marksman"
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- ...
-- Configuring Servers
-- ...

for _, name in pairs(servers) do
	lspconfig[name].setup { on_attach = on_attach }
end

require 'lspconfig'.sumneko_lua.setup {
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT 2.1',
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				-- globals = { 'vim' },
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
	on_attach = on_attach
}

require 'lspconfig'.pylsp.setup {
	on_attach = on_attach,
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					enabled = true,
					maxLineLength = 90,
					ignore = "E501"
				},
				pydocstyle = {
					enabled = true,
				},
				autopep8 = {
					enabled = true,
				},
			}
		}
	}
}



-- END
