-- START
require('packages')

-- ...
-- Treesitter
-- ...

require('nvim-treesitter.configs').setup {
	ensure_installed = {
		"python",
		"c",
		"cpp",
		"bash",
		"html",
		"lua"
	},
	highlight = {
		enable = true,
	},
	sync_install = false,
}

-- END
