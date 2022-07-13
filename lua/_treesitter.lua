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
		"lua",
		"markdown",
		"markdown_inline",
		"c_sharp",
		"julia",
	},
	highlight = {
		enable = true,
	},
	sync_install = false,
}

-- END
