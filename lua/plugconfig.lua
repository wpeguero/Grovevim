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

require("nvim-lsp-installer").setup {
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

	local opts = { noremap = true, silent = true }

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
	tnoremap <silent> <A-d> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>
	]]
end

-- ...

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

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

lspconfig.pyright.setup {}

lspconfig.bashls.setup {}

for _, name in pairs(servers) do
	lspconfig[name].setup { on_attach = on_attach }
end


-- ...

-- `nvim-cmp` comes with additional capabilities, alongside the ones
-- provided by Neovim!
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


-- ...

-- Treesitter
require('nvim-treesitter.configs').setup {
	ensure_installed = { "python", "c", "cpp", "bash", "html", "lua" },
	highlighgt = {
		enable = true, -- false will disable the whole extension
	},
}

-- ...

require("lspsaga").init_lsp_saga({
	finder_action_keys = {
		open = '<CR>',
		quit = { 'q', '<esc>' },
	},
	code_action_keys = {
		quit = { 'q', '<esc>' }
	},
	rename_action_keys = {
		quit = '<esc>',
	},
})

-- ...

-- Telescope

vim.cmd [[
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
]]

require('telescope').setup {
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<C-h>"] = "which_key"
			}
		}
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
	}
}
