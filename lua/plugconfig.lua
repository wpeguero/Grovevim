require('essentials')
require('packages')

-- ...

-- Colorscheme
vim.opt.background = "dark"
require("onedark").setup({
	style = "darker",
})
require('onedark').load()

-- ...

require("nvim-lsp-installer").setup{
	automatic_installation = true
}
local lspconfig = require("lspconfig")


-- The required servers
local servers = {
	"bashls",
	"pyright",
	"sumneko_lua",
	"html",
	"clangd",
	"vimls",
	"emmet_ls",
}

-- ...


-- Auto-install the required servers
--for _, name in pairs(servers) do
--	local server_is_found, server = lsp_installer.get_server(name)
--	if server_is_found and not server:is_installed() then
--		print("Installing " .. name)
--		server:install()
--	end
--end

-- ...

-- Setting up keymaps

local on_attach = function(_, bufnr)
	-- Create some shortcut functions.
	-- NOTE: the 'vim' variable is supplied by Neovim.
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	local opts = {noremap=true, silent=true}

	-- ========== KEYMAPS ==========
	-- Jump to definition
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)

	-- Format buffer
	buf_set_keymap('n', '<F3>', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
	-- Jump LSP diagnostics
	-- NOTE: Currently, there is a bug in lspsaga.diagnostic module. Thus we use
	-- 	Vim commands to move through diagnostics.
	buf_set_keymap('n', '[g', ':Lspsaga diagnositc_jump_prev<CR>', opts)
	buf_set_keymap('n', 'g]', ':Lspsaga diagnositc_jump_next<CR>', opts)

	-- Rename symbol
	buf_set_keymap('n', '<leader>rn', "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)

	-- Find references
	buf_set_keymap('n', 'gr', '<cmd>lua require("lspsaga.provider").lsp_finder()<CR>', opts)

	-- Doc popup scrolling
	buf_set_keymap('n', 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)

	buf_set_keymap('n', '<C-f>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)

	buf_set_keymap('n', '<C-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)

	-- codeaction
	buf_set_keymap('n', '<leader>ac', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opts)
	buf_set_keymap('n', '<leader>a', "<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", opts)

	-- Floating terminal
	-- NOTE: use `vim.cmd` since `buf_set_keymap` is not working with `tnoremap...`
	vim.cmd [[
	nnoremap <silent> <A-d> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>
	nnoremap <silent> <A-d> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>
	]]
end

-- ...


lspconfig.sumneko_lua.setup{
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals={"vim"}
			}
		}
	}
}

lspconfig.pyright.setup{}

for _, name in pairs(servers) do
	lspconfig[name].setup{on_attach = on_attach}
end

--local server_specific_opts = {
--  sumneko_lua = function(opts)
--    opts.settings = {
--      Lua = {
--        -- NOTE: This is required for expansion of lua function signatures!
--        completion = {callSnippet = "Replace"},
--        diagnostics = {
--          globals = {'vim'},
--        },
--      },
--    }
--  end,
--
--  html = function(opts)
--    opts.filetypes = {"html", "htmldjango"}
--  end,
--}

-- ...

-- `nvim-cmp` comes with additional capabilities, alongside the ones
-- provided by Neovim!
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

--lsp_installer.on_server_ready(function(server)
--  -- the keymaps, flags and capabilities that will be sent to the server as
--  -- options.
--  local opts = {
--    on_attach = on_attach,
--    flags = {debounce_text_changes = 150},
--    capabilities = capabilities,
--  }
--
--  -- If the current surver's name matches with the ones specified in the
--  -- `server_specific_opts`, set the options.
--  if server_specific_opts[server.name] then
--    server_specific_opts[server.name](opts)
--  end
--
--  -- And set up the server with our configuration!
--  server:setup(opts)
--end)

-- ...

