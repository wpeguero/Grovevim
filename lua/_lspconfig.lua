-- START
-- ...
-- Custom Key Maps for LSP Capabilities
--

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client.supports_method("textDocument/codeAction") then
			vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { unpack(args), desc = "Code Action" })
		end
		if client.supports_method("textDocument/implementation") then
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { unpack(args), desc = "Implementation" })
		end
		if client.supports_method("textDocument/formatting") then
			vim.keymap.set('n', '<space>f', vim.lsp.buf.format, { unpack(args), desc = "Format document" })
		end
		if client.supports_method("textDocument/inlayHint") then
			vim.keymap.set('n', '<leader>ih', function() vim.lsp.inlay_hint(0, nil) end, {desc = "Toggle Inlay Hints"})
		end
		if client.supports_method("textDocument/declaration") then
			vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, {unpack(args), desc = "Go to declaration"})
		end
		if client.supports_method("textdocument/definition") then
			vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {unpack(args), desc = "Go to definition"})
		end
		if client.supports_method("textdocument/typeDefinition") then
			vim.keymap.set('n', '<leader>td', vim.lsp.buf.definition, {unpack(args), desc = "Get type definition"})
		end
		if client.supports_method("textDocument/hover") then
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, {unpack(args), desc = "Get definition."})
		end
		if client.supports_method("textDocument/rename") then
			vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {unpack(args), desc = "Rename the variable."})
		end
		if client.supports_method("textDocument/signatureHelp") then
			vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help, {unpack(args), desc = "Get signature help."})
		end
		if client.supports_method("textDocument/references") then
			vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, {unpack(args), desc = "Get references."})
		end
		-- Base LSP config for each case
		if client.supports_method("textDocument/completion") then
			vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc" -- To use this, simply do <c-x><c-o>
		end
		if client.supports_method("textDocument/definition") then
			vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc" -- To use this, simply do  <c-]>
		end
		-- Inlay Hints
		if client.supports_method("textDocument/inlayHint") then
			vim.keymap.set('n', '<leader>ih', function() if vim.lsp.inlay_hint.is_enabled() then vim.lsp.inlay_hint.enable(false, {bufnr}) else vim.lsp.inlay_hint.enable(true, {bufnr}) end end, { desc = "Toggle Inlay Hints" })
			-- vim.lsp.inlay_hint.enable(true)
			-- local hint = vim.lsp.inlay_hint.get({ bufnr = 0 }) -- 0 for current buffer
			-- local hclient = vim.lsp.get_client_by_id(hint.client_id)
			-- local resp = hclient.request_sync('inlayHint/resolve', hint.inlay_hint, 100, 0)
			-- local resolved_hint = assert(resp and resp.result, resp.err)
			-- vim.lsp.util.apply_text_edits(resolved_hint.textEdits, 0, hclient.encoding)
			-- local location = resolved_hint.label[1].location
			-- hclient.request('textDocument/hover', {
			--   textDocument = { uri = location.uri },
			--   position = location.range.start,
			-- })
		end
	end,
})

-- ...
-- Setting the servers
-- ...

vim.o.updatetime = 150

local lspconfig = require("lspconfig")

local servers = {
	"bashls",
	"pylsp",
	"lua_ls",
	"html",
	"clangd",
	"vimls",
	"emmet_ls",
	"julials",
	"marksman",
	"sqlls",
	"texlab",
	"csharp_ls"
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- ...
-- Configuring Servers
-- ...

for _, name in pairs(servers) do
	lspconfig[name].setup {}
end

require 'lspconfig'.lua_ls.setup {
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
			hint = {enable = true},
		},
	},
}

require 'lspconfig'.pylsp.setup {
	settings = {
		pylsp = {
			plugins = {
			--	pycodestyle = {
			--		enabled = true,
			--		maxLineLength = 90,
			--		ignore = "E501"
			--	},
			--	autopep8 = {
			--		enabled = true,
			--	},
				ruff = {
					enabled = true,
					formatEnabled = true,
					lineLength = 90,
				}
			}
		}
	}
}

-- END
