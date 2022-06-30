require('essentials')
require('packages')

-- ...

-- `nvim-cmp` comes with additional capabilities, alongside the ones
-- provided by Neovim!
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


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
